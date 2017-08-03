class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:edit, :update]
  layout "answers"

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = current_user
  end

  def update
    address_changed = address_changed?(current_user, prms)
    if current_user.update(prms)
      GeocodeJob.perform_async(current_user.id, "User") if address_changed
      redirect_to edit_user_path(current_user, act: params[:act]),
                  notice: I18n.t(:user_updated)
    else
      flash.now[:alert] = "Возникли ошибки"
      render "edit"
    end
  end

  def listings
    @user = User.find(params[:id])
    @listings = @user.listings.includes(:state, :city).page(params[:page])
    respond_to do |format|
      format.html
      format.js do
        render partial: "shared/index", locals: { records: @listings }
      end
    end
  end

  def posts
    @user = User.find(params[:id])
    @posts = @user.posts.page(params[:page])
    respond_to do |format|
      format.html
      format.js do
        render partial: "shared/index", locals: { records: @posts }
      end
    end
  end

  def questions
    @user = User.find(params[:id])
    @questions = @user.questions.page(params[:page])
    @tags = Question.tag_counts.sort_by(&:name)
    respond_to do |format|
      format.html
      format.js do
        render partial: "shared/index", locals: { records: @questions }
      end
    end
  end

  private

  def user_params
    params.require(:user).permit(:cover, :about, :facebook, :email, :name,
                                 :google, :vk, :site, :street, :gender, :skype,
                                 :phone, :state_id, :city_id, :avatar,
                                 :show_email, :short_bio, tag_list: [])
  end

  def prms
    prms = user_params
    state_id = user_params[:state_id]
    prms[:state_slug] = State.find(state_id).slug if state_id.present?
    city_id = user_params[:city_id]
    prms[:city_slug] = City.find(city_id).slug if city_id.present?
    prms
  end
end
