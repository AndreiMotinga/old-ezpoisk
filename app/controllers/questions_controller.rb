class QuestionsController < ApplicationController
  impressionist
  before_action :authenticate_user!, only: [:new, :create, :edit]
  before_action :set_question, only: [:edit, :update, :destroy]

  def index
    if params[:tag]
      @questions = Question.tagged_with(params[:tag]).page(params[:page])
    else
      @questions = Question.includes(:answers => :user)
                           .by_keyword(params[:keyword])
                           .page(params[:page])
    end
  end

  def unanswered
    @questions = Question.by_keyword(params[:keyword])
                         .unanswered
                         .page(params[:page])
    render :index
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
      redirect_to @question, notice: I18n.t(:q_created)
    else
      render :new
    end
  end

  def update
    if @question.update(question_params)
      redirect_to @question, notice: I18n.t(:q_updated)
    else
      render :edit
    end
  end

  private
  def set_question
    @question = current_user.questions.find(params[:id])
  end

  def question_params
    params.require(:question).permit(:title, :text, tag_list: [])
  end
end
