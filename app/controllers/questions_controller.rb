class QuestionsController < ApplicationController
  impressionist actions: [:show]
  before_action :authenticate_user!, except: [:index]
  before_action :set_question, only: [:edit, :update, :destroy]

  def index
    @questions = Question.includes(:answers => :user)
                         .by_keyword(params[:keyword])
                         .by_views
                         .page(params[:page]).per(10)
  end

  def tag
    @questions = Question.tagged_with(params[:tag]).by_views.page(params[:page])
    render :index
  end

  def unanswered
    @questions = Question.by_keyword(params[:keyword])
                         .unanswered
                         .by_views
                         .page(params[:page])
    render :index
  end

  def show
    @question = Question.includes(:user, :answers).find_by_slug(params[:id])
    @question.answers.find_each { |a| impressionist a }
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
      Subscription.create(user: current_user, question: @question)
      redirect_to @question, notice: I18n.t(:q_created)
    else
      render :new
    end
  end

  def update
    if @question.update(question_params)
      SlackNotifierJob.perform_async(@question.id, "Question")
      redirect_to @question, notice: I18n.t(:q_updated)
    else
      render :edit
    end
  end

  def subscribe
    @question = Question.find(params[:id])
    Subscription.create(user: current_user, question: @question)
  end

  def unsubscribe
    @question = Question.find(params[:id])
    Subscription.find_by(user: current_user, question: @question).destroy
  end

  private

  def set_question
    @question = current_user.questions.find_by_slug(params[:id])
    redirect_to questions_path, alert: I18n.t(:news_post_not_found) unless @question
  end

  def question_params
    params.require(:question).permit(:title, :text, tag_list: [])
  end
end
