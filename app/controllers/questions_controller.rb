# frozen_string_literal: true

class QuestionsController < PagesController
  before_action :authenticate_user!, only: [:new, :create]
  after_action(only: [:index, :tag]) { create_show_impressions(@questions) }
  after_action(only: :show) do
    create_visit_impression(@question)
    create_show_impressions(@question.answers)
  end

  def index
    @questions = Question.unanswered.search(params[:term])
                                    .page(params[:page])
    @tags = Question.unanswered.tag_counts.sort_by(&:name)
    @top, @left, @right = Partner.get
    respond_to do |format|
      format.html
      format.js { render partial: "shared/index", locals: { records: @questions } }
    end
  end

  def tag
    @questions = Question.unanswered.tagged_with(params[:tag])
                                    .search(params[:term])
                                    .page(params[:page])
    @tags = Question.unanswered.tag_counts.sort_by(&:name)
    @top, @left, @right = Partner.get(tags: params[:tag])
    respond_to do |format|
      format.html { render :index }
      format.js { render partial: "shared/index", locals: { records: @questions } }
    end
  end

  def show
    @question = Question.find(params[:id])
    @top, @right = Partner.get(limit: 2, tags: @question.tag_list)
  end

  def new
    @question = Question.new
    @top = Partner.get(limit: 1)
  end

  def create
    @question = current_user.questions.build(question_params)
    if @question.save
      redirect_to @question, notice: I18n.t(:q_created)
    else
      render :new
    end
  end

  private

  def question_params
    params.require(:question).permit(:title, :text, :image_url, tag_list: [])
  end
end
