class AnswersController < ApplicationController
  before_action :authenticate_user!, only: [:create, :update, :destroy]
  before_action :set_answer, only: [:update, :destroy]

  def create
    @answer = Answer.new(answer_params)
    @answer.user_id = current_user.id

    if @answer.save
      SlackNotifierJob.perform_async(@answer.id, "Answer")
      redirect_to question_path(@answer.question), notice: "answer added"
    end
  end

  def update
    if @answer.update(answer_params)
      redirect_to question_path(@answer.question), notice: "answer added"
    else
      render :edit
    end
  end

  def destroy
    @answer.destroy
    redirect_to question_path(@answer.question), notice: "answer added"
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
      @answer = current_user.answers.find(params[:id])
    end

    def answer_params
      params.require(:answer).permit(:text, :question_id)
    end
end