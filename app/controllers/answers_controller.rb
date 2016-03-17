class AnswersController < ApplicationController
  before_action :authenticate_user!, only: [:update, :destroy]
  before_action :set_answer, only: [:update, :destroy]

  def create
    @answer = current_user.answers.build(answer_params)

    if @answer.save
      SlackNotifierJob.perform_async(@answer.id, "Answer")
      @answer.question.increment!(:answers_count)
      Subscription.create(user: current_user, question: @answer.question)
      redirect_to question_path(@answer.question), notice: I18n.t(:answer_created)
    end
  end

  def update
    if @answer.update(answer_params)
      SlackNotifierJob.perform_async(@answer.id, "Answer")
      redirect_to question_path(@answer.question), notice: I18n.t(:answer_updated)
    else
      render :edit
    end
  end

  def destroy
    @answer.destroy
    redirect_to question_path(@answer.question), notice: "answer removed"
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
      if current_user.admin?
        @answer = Answer.find(params[:id])
      else
        @answer = current_user.answers.find(params[:id])
      end
    end

    def answer_params
      params.require(:answer).permit(:text, :question_id)
    end
end
