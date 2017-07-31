class QuestionsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]
  layout "answers"

  def index
    @questions = Question.unanswered.search(params[:term])
                                    .page(params[:page])
    @tags = Question.unanswered.tag_counts.sort_by(&:name)
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
    respond_to do |format|
      format.html { render :index }
      format.js { render partial: "shared/index", locals: { records: @questions } }
    end
  end

  def show
    @question = Question.find(params[:id])
  end

  def new
    @question = Question.new
  end

  def create
    @question = current_user.questions.build(question_params)
    verify_title

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

  def verify_title
    @question.title += "?" unless @question.title.strip.match(/\?$/)
    @question.title.mb_chars.capitalize.to_s
  end
end
