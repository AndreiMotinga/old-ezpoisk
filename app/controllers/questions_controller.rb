class QuestionsController < ApplicationController
  impressionist actions: [:show]
  before_action :authenticate_user!, except: [:index]
  before_action :set_question, only: [:edit, :update, :destroy]
  before_action :set_partners, only: [:index, :show, :tag, :unanswered, :new, :edit]

  def index
    @questions = Question.includes(:answers => :user)
                         .by_keyword(params[:keyword])
                         .by_views
                         .page(params[:page]).per(10)
    @unanswered = Question.by_keyword(params[:keyword])
                          .unanswered
                          .by_views
                          .limit(10)
  end

  def tag
    @questions = Question.tagged_with(params[:tag], any: true).by_views.page(params[:page])
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
    if Question.exists?(params[:id])
      @question = Question.includes(:user, :answers).find(params[:id])
      @question.answers.find_each { |a| impressionist a }
    else
      redirect_to questions_path, alert: I18n.t(:q_not_found)
    end
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
    redirect_to questions_path, alert: I18n.t(:q_not_found) unless @question
  end

  def question_params
    params.require(:question).permit(:title, :text, tag_list: [])
  end

  def set_partners
    # todo change page
    @partner_ads = PartnerAds.new("Недвижимость", 1, 1, 1)
  end
end
