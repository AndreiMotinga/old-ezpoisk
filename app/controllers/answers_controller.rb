class AnswersController < ApplicationController
  before_action :set_answer, only: [:update, :destroy]

  def index
    @answers = Answer.includes(:user, question: :taggings)
    @answers = @answers.page(params[:page]).per(10)
    IncreaseImpressionsJob.perform_async(@answers.pluck(:id), "Answer")
  end

  def show
    @answer = Answer.find(params[:id])
    @new_comment = Comment.build_from(@answer, current_user.try(:id )|| 4, "")
    @posts = Post.last(10)
  end

  def new
    question = Question.find(params[:question_id])
    @answer = question.answers.new
  end

  def create
    @answer = current_user.answers.build(answer_params)
    if @answer.save
      run_jobs_and_notifications
      redirect_to(question_path(question), notice: I18n.t(:answer_created))
    end
  end

  def edit
    @answer = Answer.find(params[:id])
  end

  def update
    if @answer.update(answer_params)
      redirect_to(question_path(question), notice: I18n.t(:answer_updated))
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

  def run_jobs_and_notifications
    SlackNotifierJob.perform_async(@answer.id, "Answer")
    QuestionNotificatorJob.perform_async(question.id)
    question.increment!(:answers_count)
    question.entry.try(:touch)
    create_subscription
  end

  def set_answer
    id = params[:id]
    return @answer = Answer.find(id) if current_user.admin?
    @answer = current_user.answers.find(id)
  end

  def answer_params
    params.require(:answer).permit(:text, :question_id)
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
