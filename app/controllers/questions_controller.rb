class QuestionsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :edit]

  def index
    @questions = Question.includes(:taggings)
                         .by_keyword(params[:keyword])
                         .page(params[:page]).per(10)
    IncreaseImpressionsJob.perform_async(@questions.pluck(:id), "Question")
    @tags = Question.tag_counts.sort_by(&:name)
    respond_to do |format|
      format.html
      format.js do
        render partial: "shared/index", locals: { records: @questions }
      end
    end
  end

  def unanswered
    @questions = Question.unanswered.includes(:taggings)
                          .by_keyword(params[:keyword])
                          .page(params[:page]).per(10)
    IncreaseImpressionsJob.perform_async(@questions.pluck(:id), "Question")
    @tags = Question.unanswered.tag_counts.sort_by(&:name)
    respond_to do |format|
      format.html
      format.js { render partial: "shared/index", locals: { records: @questions } }
    end
  end

  def unanswered_tag
    @questions = Question.unanswered
                         .includes(:taggings)
                         .tagged_with(params[:tag])
                         .by_keyword(params[:keyword])
                         .page(params[:page]).per(10)
    IncreaseImpressionsJob.perform_async(@questions.pluck(:id), "Question")
    @tags = Question.unanswered.tag_counts.sort_by(&:name)
    respond_to do |format|
      format.html
      format.js { render partial: "shared/index", locals: { records: @questions } }
    end
  end

  def tag
    @questions  = Question.includes(:taggings)
    @questions = @questions.tagged_with(params[:tag]) if params[:tag].present?
    @questions = @questions.by_views.page(params[:page])
    IncreaseImpressionsJob.perform_async(@questions.pluck(:id), "Question")
    @tags = Question.tag_counts.sort_by(&:name)
    respond_to do |format|
      format.html
      format.js { render partial: "shared/index", locals: { records: @questions } }
    end
  end

  def show
    @question = Question.includes(:user).find(params[:id])
    IncreaseVisitsJob.perform_in(12.minutes, @question.id, "Question")
  end

  def new
    @question = Question.new
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

  private

  def create_subscription
    Subscription.create(
      user: current_user,
      subscribable_id: @question.id,
      subscribable_type: @question.class.to_s
    )
  end

  def question_params
    params.require(:question).permit(:title, :text, :image_url, tag_list: [])
  end
end
