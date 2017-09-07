# frozen_string_literal: true

class QuestionsController < PagesController
  before_action :authenticate_user!, only: [:new, :create]
  before_action :set_question, only: [:edit, :update]
  after_action(only: [:index, :tag]) { create_show_impressions(@questions) }
  after_action(only: :show) do
    create_visit_impression(@question)
    create_show_impressions(@question.answers)
  end
  after_action(only: :create) { notify_slack(@question, action_name) }

  def index
    @questions = Question.desc.page(params[:page])
    @top, @left, @right = Partner.get
    respond_to do |format|
      format.html
      format.js { render partial: "shared/index", locals: { records: @questions } }
    end
  end

  def tag
    @questions = Question.tag_list(params[:tag]).page(params[:page])
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
    @question.user_id = 4 if @question.anonymously?
    if @question.save
      @question.karmas.create(user: current_user,
                              giver: current_user,
                              kind: "created")
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

  def upvote
    @record = Question.find(params[:id])
    @record.upvote_by current_user
    @record.update_attribute(:votes_count, @record.score)
    @record.karmas.create(user: @record.user,
                          giver: current_user,
                          kind: "upvoted")
    render "shared/votes/upvote.js.erb"
  end

  def downvote
    @record = Question.find(params[:id])
    @record.unvote_by current_user if current_user.voted_for? @record
    @record.downvote_by current_user
    @record.update_attribute(:votes_count, @record.score)
    @record.karmas.where(user: @record.user,
                         giver: current_user,
                         kind: "upvoted").destroy_all
    render "shared/votes/downvote.js.erb"
  end

  def unvote
    @record = Question.find(params[:id])
    @record.unvote_by current_user
    @record.update_attribute(:votes_count, @record.score)
    @record.karmas.where(user: @record.user,
                         giver: current_user,
                         kind: "upvoted").destroy_all
    render "shared/votes/unvote.js.erb"
  end


  private

  def question_params
    params.require(:question).permit(:title, :text, :anonymously,
                                     :source, tag_list: [])
  end

  def set_question
    if current_user.member?
      @question = Question.find(params[:id])
    else
      @question = current_user.questions.find(params[:id])
    end
  end
end
