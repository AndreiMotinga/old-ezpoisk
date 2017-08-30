# frozen_string_literal: true

class UsersController < PagesController
  before_action :authenticate_user!, only: [:edit, :update, :upvote, :unvote]
  before_action :set_user, only: [:show, :posts, :questions]
  after_action(only: :show) { create_visit_impression(@user) }
  after_action(only: :update) { notify_slack(current_user, action_name) }

  def show
    @answers = @user.answers.page(params[:page])
    respond_to do |format|
      format.html
      format.js do
        render partial: "shared/index", locals: { records: @answers }
      end
    end
  end

  def edit
    @user = current_user
  end

  def update
    if current_user.update(user_params)
      redirect_to edit_user_path(current_user, act: params[:act]),
                  notice: I18n.t(:user_updated)
    else
      flash.now[:alert] = "Возникли ошибки"
      render "edit"
    end
  end

  def listings
    @user = User.find(params[:id])
    @listings = @user.listings
                     .where.not(kind: %W(разное новости))
                     .includes(:state, :city).page(params[:page])
    respond_to do |format|
      format.html
      format.js do
        render partial: "shared/index", locals: { records: @listings }
      end
    end
  end

  def posts
    @posts = @user.posts.page(params[:page])
    respond_to do |format|
      format.html
      format.js do
        render partial: "shared/index", locals: { records: @posts }
      end
    end
  end

  def questions
    @questions = @user.questions.page(params[:page])
    @tags = Question.tag_counts.sort_by(&:name)
    respond_to do |format|
      format.html
      format.js do
        render partial: "shared/index", locals: { records: @questions }
      end
    end
  end

  def upvote
    @user = User.find(params[:id])
    @user.upvote_by current_user
    Karma.create(user: @user,
                 karmable_type: "User",
                 karmable_id: @user.id,
                 giver: current_user,
                 kind: "thanked")
  end

  def unvote
    @user = User.find(params[:id])
    @user.unvote_by current_user
    Karma.where(user: @user,
                karmable_type: "User",
                karmable_id: @user.id,
                giver: current_user,
                kind: "thanked").destroy_all
  end

  private

  def user_params
    params.require(:user).permit(:gender, :name, :about, :avatar, :short_bio,
                                 skill_list: [], interest_list: [])
  end

  def set_user
    redirect_to root_url if [1, 4].include?(params[:id].to_i)
    @user = User.find(params[:id])
  end
end
