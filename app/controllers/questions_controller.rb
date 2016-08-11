class QuestionsController < ApplicationController
  before_action :authenticate_user!, only: [:new]
  before_action :set_question, only: [:edit, :update, :destroy]
  # before_action :set_partners, only: [:index, :show, :tag, :unanswered]

  def index
    qs = Question.includes(:taggings).by_keyword(params[:keyword])
    @questions = qs.page(params[:page]).per(10)
  end

  def tag
    @questions = Question.includes(:taggings)
                          .tagged_with(params[:tag], any: true)
                         .by_views.page(params[:page])
    render :index
  end

  def unanswered
    qs = Question.unanswered.includes(:taggings)
    tag = params[:tag]
    qs = qs.tagged_with(tag) if tag
    @questions = qs.by_views.page(params[:page])
  end

  def show
    @question = Question.includes(:user).find(params[:id])
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
      create_subscription
      @question.create_entry(user: current_user)
      redirect_to @question, notice: I18n.t(:q_created)
    else
      render :new
    end
  end

  def update
    if @question.update(question_params)
      SlackNotifierJob.perform_async(@question.id, "Question")
      @question.entry.try(:touch)
      redirect_to @question, notice: I18n.t(:q_updated)
    else
      render :edit
    end
  end

  private

  def create_subscription
    Subscription.create(
      user: current_user,
      subscribable_id: @question.id,
      subscribable_type: @question.class.to_s
    )
  end

  def set_question
    @question = current_user.questions.find_by_slug(params[:id])
    redirect_to answers_path, alert: I18n.t(:q_not_found) unless @question
  end

  def question_params
    params.require(:question).permit(:title, :text, :image_url, tag_list: [])
  end

  def set_partners
    @partner_ads = PartnerAds.new("Вопросы")
  end
end
