class Dashboard::ProfilesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_profile

  def edit
  end

  def update
    address_changed = address_changed?(@profile, profile_params)
    if @profile.update(profile_params)
      GeocodeJob.perform_async(@profile.id, "Profile") if address_changed
      redirect_to(edit_dashboard_profile_path(@profile),
                  notice: I18n.t(:profile_updated))
    else
      flash.now[:alert] = "Возникли ошибки"
      render :edit
    end
  end

  private

  def set_profile
    @profile = current_user.profile
  end

  def profile_params
    params.require(:profile).permit(:cover, :about, :work, :facebook,
                                    :google, :vk, :ok, :site, :twitter, :street,
                                    :motto, :phone, :state_id, :city_id)
  end
end
