class UsersController < ApplicationController
  before_action :authenticate_user!

  def edit
  end

  def update
    address_changed = address_changed?(current_user, prms)
    if current_user.update(prms)
      GeocodeJob.perform_async(current_user.id, "User") if address_changed
      redirect_to edit_user_path(current_user),
                  notice: I18n.t(:user_updated)
    else
      flash.now[:alert] = "Возникли ошибки"
      render "dashboard/users/edit"
    end
  end

  private

  def user_params
    params.require(:user).permit(:cover, :about, :facebook, :email, :name,
                                 :google, :vk, :ok, :site, :twitter, :street,
                                 :phone, :state_id, :city_id, :avatar,
                                 :show_email, :slug)
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
