class QuestionsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :edit]
  before_action :set_question, only: [:edit, :update, :destroy]

  def index
    @questions = Question.includes(:taggings)
                          .by_keyword(params[:keyword])
                          .page(params[:page]).per(10)
    IncreaseImpressionsJob.perform_async(@questions.pluck(:id), "Question")
    respond_to do |format|
      format.html
      format.js { render partial: "shared/index", locals: { records: @questions } }
    end
  end

  def tag
    @questions = Question.includes(:taggings)
                         .tagged_with(params[:tag], any: true)
                         .by_views.page(params[:page])
    IncreaseImpressionsJob.perform_async(@questions.pluck(:id), "Question")

    respond_to do |format|
      format.html { render :index }
      format.js { render partial: "shared/index", locals: { records: @questions } }
    end
  end

  def unanswered
    @questions  = Question.unanswered.includes(:taggings)
    @questions = @questions.tagged_with(params[:tag]) if params[:tag].present?
    @questions = @questions.by_views.page(params[:page])
    IncreaseImpressionsJob.perform_async(@questions.pluck(:id), "Question")
    respond_to do |format|
      format.html { render :index }
      format.js { render partial: "shared/index", locals: { records: @questions } }
    end
  end

  def show
    @question = Question.find(params[:id])
    IncreaseVisitsJob.perform_async(@question.id, "Question")
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
end
