class AnswersController < ApplicationController
  before_action :authenticate_user!, only: [:new, :edit]
  before_action :set_answer, only: [:edit, :update, :destroy]

  def index
    @answers = Answer.includes(:user, :taggings)
                     .page(params[:page]).per(10)
    IncreaseImpressionsJob.perform_async(@answers.pluck(:id), "Answer")
    respond_to do |format|
      format.html
      format.js { render partial: "shared/index", locals: { records: @answers } }
    end
  end

  def tag
    @answers = Answer.includes(:user, :taggings)
                     .tagged_with(params[:tag], any: true)
                     .page(params[:page])
    IncreaseImpressionsJob.perform_async(@answers.pluck(:id), "Answer")

    respond_to do |format|
      format.html { render :index }
      format.js { render partial: "shared/index", locals: { records: @answers } }
    end
  end

  def show
    @answer = Answer.find(params[:id])
    @new_comment = Comment.build_from(@answer, current_user.try(:id)|| 4, "")
    IncreaseVisitsJob.perform_async(@answer.id, 'Answer')
  end

  def new
    question = Question.find(params[:question_id])
    @answer = question.answers.new
  end

  def create
    @answer = current_user.answers.build(answer_params)
    if @answer.save
      run_create_notifications
      redirect_to(question_path(question), notice: I18n.t(:answer_created))
    end
  end

  def edit
  end

  def update
    if @answer.update(answer_params)
      redirect_to(answer_path(@answer), notice: I18n.t(:answer_updated))
    else
      render :edit
    end
  end

  def destroy
    question.decrement!(:answers_count)
    @answer.destroy
    redirect_to question_path(question), notice: "Ответ удален"
  end

  def upvote
    @answer = Answer.find(params[:id])
    @answer.upvote_by current_user
  end

  def downvote
    @answer = Answer.find(params[:id])
    @answer.unvote_by current_user if current_user.voted_for? @answer
    @answer.downvote_by current_user
  end

  def unvote
    @answer = Answer.find(params[:id])
    @answer.unvote_by current_user
  end

  private

  def run_create_notifications
    SlackNotifierJob.perform_async(@answer.id, "Answer")
    QuestionNotificatorJob.perform_async(question.id)
    question.increment!(:answers_count)
    question.entry.try(:touch)
    create_subscription
  end

  def set_answer
    @answer = Answer.find(params[:id])
    @answer = nil unless @answer.user.can_edit?(current_user)
  end

  def answer_params
    params.require(:answer).permit(:text, :question_id, :title, tag_list: [])
  end

  def create_subscription
    return if Subscription.exists?(
      user_id: current_user.id,
      subscribable_id: @answer.id,
      subscribable_type: @answer.class.to_s
    )
    Subscription.create(
      user_id: current_user.id,
      subscribable_id: @answer.id,
      subscribable_type: @answer.class.to_s
    )
  end

  def question
    @answer.question
  end
end
