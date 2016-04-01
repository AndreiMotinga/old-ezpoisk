class Dashboard::ServicesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_service, only: [:edit, :update, :destroy]

  def new
    @service = Service.new state_id: current_user.state_id,
                           city_id: current_user.city_id,
                           active: true,
                           phone: current_user.phone,
                           email: current_user.email
  end

  def edit
  end

  def create
    @service = current_user.services.build(service_params)

    if @service.save
      SlackNotifierJob.perform_async(@service.id, "Service")
      AdminMailerJob.perform_async(@service.id, "Service")
      GeocodeJob.perform_async(@service.id, "Service")
      redirect_to edit_dashboard_service_path(@service),
                  notice: I18n.t(:post_saved)
    else
      flash.now[:alert] = I18n.t(:post_not_saved)
      render :new
    end
  end

  def update
    address_changed = address_changed?(@service, service_params)
    if @service.update(service_params)
      GeocodeJob.perform_async(@service.id, "Service") if address_changed
      redirect_to edit_dashboard_service_path(@service),
                  notice: I18n.t(:post_saved)
    else
      flash.now[:alert] = I18n.t(:post_not_saved)
      render :edit
    end
  end

  def destroy
    @service.destroy
    redirect_to dashboard_path, notice: I18n.t(:post_removed)
  end

  private

  def set_service
    @service = current_user.services.find(params[:id])
  end

  def service_params
    params.require(:service).permit(:title,
                                    :street,
                                    :phone,
                                    :fax,
                                    :email,
                                    :site,
                                    :description,
                                    :active,
                                    :state_id,
                                    :city_id,
                                    :logo,
                                    :short_description,
                                    :category,
                                    :subcategory)
  end
end
