class Dashboard::ProfilesController < ApplicationController
  before_action :authenticate_user!

  def edit
  end

  def update
    if current_user.profile.update(profile_params)
      redirect_to(edit_dashboard_profile_path(current_user.profile),
                  notice: I18n.t(:profile_updated))
    else
      flash.now[:alert] = "Возникли ошибки"
      render :edit
    end
  end

  private

  def profile_params
    params.require(:profile).permit(:avatar, :cover, :about, :work, :facebook,
                                   :google, :vk, :ok, :site, :twitter, :name,
                                   :motto, :phone, :state_id, :city_id, :street)
  end
end
