# frozen_string_literal: true

class QuestionsController < PagesController
  before_action :authenticate_user!, only: [:new, :create]
  before_action :set_question, only: [:edit, :update]
  after_action(only: [:index, :tag]) { create_show_impressions(@questions) }
  after_action(only: :show) do
    create_visit_impression(@question)
    create_show_impressions(@question.answers)
  end

  def index
    set_questions
    set_tags
    @top, @left, @right = Partner.get
    respond_to do |format|
      format.html
      format.js { render partial: "shared/index", locals: { records: @questions } }
    end
  end

  def tag
    @questions = Question.tagged_with(params[:tag]).page(params[:page])
    set_tags
    @top, @left, @right = Partner.get(tags: params[:tag])
    respond_to do |format|
      format.html { render :index }
      format.js { render partial: "shared/index", locals: { records: @questions } }
    end
  end

  def show
    @question = Question.find(params[:id])
    @top, @right, @inline = Partner.get(tags: @question.tag_list)
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

  def edit
  end

  def update
    # todo prevent user from changing the content of teh question completely
    if @question.update(question_params)
      redirect_to @question, notice: I18n.t(:q_updated)
    else
      render :new
    end
  end

  def destroy
    return unless current_user&.member?
    Question.find(params[:id]).destroy
    redirect_to questions_url
  end

  private

  def question_params
    params.require(:question).permit(:title, :text, tag_list: [])
  end

  def set_tags
    if user_signed_in?
      @tags = current_user.interest_list
    else
      @tags = Question.tag_counts.order("count desc").take(5).pluck(:name)
    end
  end

  def set_questions
    @questions = Question.desc
    if params[:all].present? || current_user&.skill_list&.empty?
      # don't filter anymore
    elsif user_signed_in?
      @questions = @questions.tagged_with(current_user.skill_list, any: true)
    end
    @questions = @questions.page(params[:page])
  end

  def set_question
    if current_user.member?
      @question = Question.find(params[:id])
    else
      @question = current_user.questions.find(params[:id])
    end
  end
end
