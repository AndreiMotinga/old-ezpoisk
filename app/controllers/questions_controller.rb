class QuestionsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_question, only: [:edit, :update, :destroy]
  before_action :set_partners, only: [:index, :show, :tag, :unanswered]

  def index
    qs = Question.by_keyword(params[:keyword])
    @questions = qs.order("created_at desc").page(params[:page]).per(10)
    @unanswered = qs.unanswered.order("created_at desc").limit(10)
  end

  def tag
    @questions = Question.tagged_with(params[:tag], any: true)
                         .by_views.page(params[:page])
    render :index
  end

  def unanswered
    qs = Question.unanswered
    tag = params[:tag]
    qs = qs.tagged_with(tag) if tag
    @questions = qs.by_views.page(params[:page])
  end

  def show
    @question = Question.includes(:user, :answers).find(params[:id])
    @question.increment!(:impressions_count)
    @question.answers.find_each { |a| a.increment!(:impressions_count) }
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
    params.require(:question).permit(:title, :text, :image_url, tag_list: [])
  end

  def set_partners
    @partner_ads = PartnerAds.new("Вопросы")
  end
end
