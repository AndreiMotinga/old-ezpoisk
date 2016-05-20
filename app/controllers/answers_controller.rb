class AnswersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_answer, only: [:update, :destroy]

  def new
    @answer = Question.find(params[:question_id]).answers.new
  end

  def create
    @answer = current_user.answers.build(answer_params)

    if @answer.save
      run_backgound_jobs
      question.increment!(:answers_count)
      Subscription.create(user: current_user, question: question)
      redirect_to(question_path(question), notice: I18n.t(:answer_created))
    end
  end

  def edit
    @answer = Answer.find(params[:id])
  end

  def update
    if @answer.update(answer_params)
      SlackNotifierJob.perform_async(@answer.id, "Answer")
      redirect_to(question_path(question),
                  notice: I18n.t(:answer_updated))
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

  def set_answer
    id = params[:id]
    return @answer = Answer.find(id) if current_user.admin?
    @answer = current_user.answers.find(id)
  end

  def answer_params
    params.require(:answer).permit(:text, :question_id)
  end

  def run_backgound_jobs
    SlackNotifierJob.perform_async(@answer.id, "Answer")
    q_id = question.id
    QuestionNotificatorJob.perform_async(q_id)
    CreateSubscriptionJob.perform_async(current_user.id, q_id) if current_user
  end

  def question
    @answer.question
  end
end
