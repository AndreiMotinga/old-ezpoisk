class QuestionsController < ApplicationController
  def index
    @questions = Question.search(params[:term]).page(params[:page])
    IncreaseImpressionsJob.perform_async(@questions.pluck(:id), "Question")
    @tags = Question.tag_counts.sort_by(&:name)
    respond_to do |format|
      format.html
      format.js do
        render partial: "shared/index", locals: { records: @questions }
      end
    end
  end

  def tag
    @questions = Question.tagged_with(params[:tag]).page(params[:page])
    IncreaseImpressionsJob.perform_async(@questions.pluck(:id), "Question")
    @tags = Question.tag_counts.sort_by(&:name)
    respond_to do |format|
      format.html { render :index }
      format.js { render partial: "shared/index", locals: { records: @questions } }
    end
  end


  def unanswered
    @questions = Question.unanswered.search(params[:term])
                                    .page(params[:page])
    IncreaseImpressionsJob.perform_async(@questions.pluck(:id), "Question")
    @tags = Question.unanswered.tag_counts.sort_by(&:name)
    respond_to do |format|
      format.html
      format.js { render partial: "shared/index", locals: { records: @questions } }
    end
  end

  def unanswered_tag
    @questions = Question.unanswered.tagged_with(params[:tag])
                                    .search(params[:term])
                                    .page(params[:page])
    IncreaseImpressionsJob.perform_async(@questions.pluck(:id), "Question")
  @tags = Question.unanswered.tag_counts.sort_by(&:name)
    respond_to do |format|
      format.html { render :unanswered }
      format.js { render partial: "shared/index", locals: { records: @questions } }
    end
  end

  def show
    @question = Question.find(params[:id])
    IncreaseVisitsJob.perform_in(12.minutes, @question.id, "Question")
  end

  def new
    @question = Question.new
  end

  def create
    @question = Question.new(question_params)
    @question.user = current_user
    verify_title

    if @question.save
      SlackNotifierJob.perform_async(@question.id, "Question")
      create_subscription if @question.user
      @question.update_cached_tags
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

  def verify_title
    @question.title += "?" unless @question.title.strip.match(/\?$/)
    @question.title.mb_chars.capitalize.to_s
  end
end
