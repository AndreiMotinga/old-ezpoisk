class AnswersController < ApplicationController
  before_action :authenticate_user!, only: [:edit]
  before_action :set_answer, only: [:edit, :update, :destroy]

  def index
    @answers = Answer.includes(:user, :taggings)
                     .page(params[:page]).per(10)
    IncreaseImpressionsJob.perform_in(1.minute, @answers.pluck(:id), "Answer")
    respond_to do |format|
      format.html
      format.js { render partial: "shared/index", locals: { records: @answers } }
    end
  end

  def tag
    @answers = Answer.includes(:user, :taggings)
                     .tagged_with(params[:tag], any: true)
                     .page(params[:page])
    IncreaseImpressionsJob.perform_in(1.minute, @answers.pluck(:id), "Answer")

    respond_to do |format|
      format.html { render :index }
      format.js { render partial: "shared/index", locals: { records: @answers } }
    end
  end

  def show
    @answer = Answer.find(params[:id])
    IncreaseImpressionsJob.perform_in(1.minutes, [@answer.id], 'Answer')
  end

  def new
    question = Question.find(params[:question_id])
    @answer = question.answers.new
  end

  def create
    user = user_signed_in? ? current_user : User.find(4)
    @answer = user.answers.build(answer_params)
    @answer.title = @answer.question.title
    if @answer.save
      run_create_notifications(user)
      redirect_to(answer_path(@answer), notice: I18n.t(:answer_created))
    else
      flash.now[:alert] = I18n.t(:review_not_saved)
      render :new
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
    @answer.update_attribute(:votes_count, @answer.score)
  end

  def downvote
    @answer = Answer.find(params[:id])
    @answer.unvote_by current_user if current_user.voted_for? @answer
    @answer.downvote_by current_user
    @answer.update_attribute(:votes_count, @answer.score)
  end

  def unvote
    @answer = Answer.find(params[:id])
    @answer.unvote_by current_user
    @answer.update_attribute(:votes_count, @answer.score)
  end

  private

  def run_create_notifications(user)
    SlackNotifierJob.perform_async(@answer.id, "Answer")
    QuestionNotificatorJob.perform_async(question.id)
    FbExporterJob.perform_in(11.minutes, @answer.id, "Answer")
    VkExporterJob.perform_in(23.minutes, @answer.id, "Answer")
    question.increment!(:answers_count)
    @answer.create_entry(user: user)
    create_subscription(user)
  end

  def set_answer
    @answer = Answer.find(params[:id])
    @answer = nil unless current_user.try(:can_edit?, @answer)
  end

  def answer_params
    params.require(:answer).permit(:text, :question_id, :title,
                                   :image_remote_url, tag_list: [])
  end

  def create_subscription(user)
    return if Subscription.exists?(
      user_id: user.id,
      subscribable_id: @answer.id,
      subscribable_type: @answer.class.to_s
    )
    Subscription.create(
      user_id: user.id,
      subscribable_id: @answer.id,
      subscribable_type: @answer.class.to_s
    )
  end

  def question
    @answer.question
  end
end
