class QuestionsController < ApplicationController
  impressionist
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :upvote, :downvote]
  before_action :set_question, only: [:edit, :update, :destroy]

  def index
    @questions = Question.all.includes(:user).by_score
    @questions = Kaminari.paginate_array(@questions).page(params[:page])
  end

  def show
    @question = Question.find(params[:id])
  end

  def new
    @question = Question.new
  end

  def edit
  end

  def create
    @question = current_user.questions.build(question_params)

    if @question.save
      SlackNotifierJob.perform_async(@question.id, "Question")
      redirect_to @question, notice: 'Question was successfully created.'
    else
      render :new
    end
  end

  def upvote
    @question = Question.find(params[:id])
    @question.upvote_by current_user
  end

  def downvote
    @question = Question.find(params[:id])
    @question.unvote_by current_user if current_user.voted_for? @question
    @question.downvote_by current_user
  end

  def unvote
    @question = Question.find(params[:id])
    @question.unvote_by current_user
  end

  def update
    if @question.update(question_params)
      redirect_to @question, notice: 'Question was successfully updated.'
    else
      render :edit
    end
  end

  private
  def set_question
    @question = current_user.questions.find(params[:id])
  end

  def question_params
    params.require(:question).permit(:title, :text)
  end
end
