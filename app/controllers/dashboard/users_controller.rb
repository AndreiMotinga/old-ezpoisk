class Dashboard::UsersController < ApplicationController
  before_action :authenticate_user!

  def edit
  end

  def update
    address_changed = address_changed?(current_user, user_params)
    if current_user.update(user_params)
      GeocodeJob.perform_async(current_user.id, "User") if address_changed
      redirect_to edit_dashboard_user_path(current_user),
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
                                    :phone, :state_id, :city_id, :avatar)
  end
end
