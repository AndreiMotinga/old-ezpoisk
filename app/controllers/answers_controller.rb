# frozen_string_literal: true

class AnswersController < PagesController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  before_action :set_answer, only: [:edit, :update, :destroy]
  after_action(only: [:index, :tag]) { create_show_impressions(@answers) }
  after_action(only: :show) do
    create_visit_impression(@answer)
    create_visit_impression(@answer.question)
  end
  after_action(only: [:create, :update]) { notify_slack(@answer, action_name) }

  def index
    @answers = Answer.includes(:user).term(params[:term]).desc.page(params[:page])
    @top, @left, @right = Partner.side
    respond_to do |format|
      format.html
      format.js { render partial: "shared/index", locals: { records: @answers } }
    end
  end

  def tag
    @answers = Answer.includes(:user)
                     .tagged_with(params[:tag])
                     .page(params[:page])
    @top, @left, @right = Partner.side
    respond_to do |format|
      format.html { render :index }
      format.js { render partial: "shared/index", locals: { records: @answers } }
    end
  end

  def show
    @answer = Answer.find(params[:id])
    @top, @right = Partner.side
    @inline = Partner.inline(1, { tags: @answer.tag_list })
  end

  def new
    question = Question.find(params[:question_id])
    @answer = question.answers.new
    @top = Partner.side(1)
  end

  def create
    @answer = current_user.answers.build(answer_params)
    @answer.user_id = 4 if @answer.anonymously?
    @answer.title = @answer.question.title

    if @answer.save
      @answer.karmas.create(user: current_user,
                            giver: current_user,
                            kind: "created")
      redirect_to(answer_path(@answer), notice: I18n.t(:answer_created))
    else
      flash.now[:alert] = I18n.t(:review_not_saved)
      render :new
    end
  end

  def edit
    @top = Partner.side(1)
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
    @answer.karmas.destroy_all
    @answer.destroy
    redirect_to question_path(question), notice: "Ответ удален"
  end

  def upvote
    @record = Answer.find(params[:id])
    @record.upvote_by current_user
    @record.update_attribute(:votes_count, @record.score)
    @record.karmas.create(user: @record.user,
                          giver: current_user,
                          kind: "upvoted")
    render "shared/votes/upvote.js.erb"
  end

  def downvote
    @record = Answer.find(params[:id])
    @record.unvote_by current_user if current_user.voted_for? @record
    @record.downvote_by current_user
    @record.update_attribute(:votes_count, @record.score)
    @record.karmas.where(user: @record.user,
                         giver: current_user,
                         kind: "upvoted").destroy_all
    render "shared/votes/downvote.js.erb"
  end

  def unvote
    @record = Answer.find(params[:id])
    @record.unvote_by current_user
    @record.update_attribute(:votes_count, @record.score)
    @record.karmas.where(user: @record.user,
                         giver: current_user,
                         kind: "upvoted").destroy_all
    render "shared/votes/unvote.js.erb"
  end

  private

  def set_answer
    @answer = Answer.find(params[:id])
    @answer = nil unless current_user.try(:can_edit?, @answer)
  end

  def answer_params
    params.require(:answer).permit(:text, :question_id, :title, :anonymously,
                                   :image_remote_url, tag_list: [])
  end

  def question
    @answer.question
  end
end
