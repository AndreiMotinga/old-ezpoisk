# frozen_string_literal: true

class AnswersController < PagesController
  before_action :authenticate_user!, only: [:edit]
  before_action :set_answer, only: [:edit, :update, :destroy]
  after_action(only: [:index, :tag]) { create_show_impressions(@answers) }
  after_action(only: :show) do
    create_visit_impression(@answer)
    create_visit_impression(@answer.question)
  end

  def index
    @answers = Answer.includes(:user).page(params[:page])
    @top, @left, @right = Partner.get
    respond_to do |format|
      format.html
      format.js { render partial: "shared/index", locals: { records: @answers } }
    end
  end

  def tag
    @answers = Answer.includes(:user)
                     .tagged_with(params[:tag])
                     .page(params[:page])
    @top, @left, @right = Partner.get(tags: params[:tag])
    respond_to do |format|
      format.html { render :index }
      format.js { render partial: "shared/index", locals: { records: @answers } }
    end
  end

  def show
    @answer = Answer.find(params[:id])
    @top, @right = Partner.get(limit: 2, tags: @answer.tag_list)
  end

  def new
    question = Question.find(params[:question_id])
    @answer = question.answers.new
    @top = Partner.get(limit: 1, tags: question.tag_list)
  end

  def create
    user = user_signed_in? ? current_user : User.find(4)
    @answer = user.answers.build(answer_params)
    @answer.title = @answer.question.title
    @answer.cached_tags = @answer.question.tags.pluck(:name).join(", ")

    if @answer.save
      SlackNotifierJob.perform_async(@answer.id, "Answer")
      redirect_to(answer_path(@answer), notice: I18n.t(:answer_created))
    else
      flash.now[:alert] = I18n.t(:review_not_saved)
      render :new
    end
  end

  def edit
    @top = Partner.get(limit: 1, tags: @answer.tag_list)
  end

  def update
    if @answer.update(answer_params)
      redirect_to(answer_path(@answer), notice: I18n.t(:answer_updated))
    else
      render :edit
    end
  end

  def destroy
    question.decrement!(:answers_count)
    @answer.destroy
    redirect_to question_path(question), notice: "Ответ удален"
  end

  def upvote
    @answer = Answer.find(params[:id])
    @answer.upvote_by current_user
    @answer.update_attribute(:votes_count, @answer.score)
  end

  def downvote
    @answer = Answer.find(params[:id])
    @answer.unvote_by current_user if current_user.voted_for? @answer
    @answer.downvote_by current_user
    @answer.update_attribute(:votes_count, @answer.score)
  end

  def unvote
    @answer = Answer.find(params[:id])
    @answer.unvote_by current_user
    @answer.update_attribute(:votes_count, @answer.score)
  end

  private

  def set_answer
    @answer = Answer.find(params[:id])
    @answer = nil unless current_user.try(:can_edit?, @answer)
  end

  def answer_params
    params.require(:answer).permit(:text, :question_id, :title,
                                   :image_remote_url, tag_list: [])
  end

  def question
    @answer.question
  end
end
