# create tests
class Dashboard::ServicesController < ApplicationController
  layout "dashboard"
  before_action :authenticate_user!
  before_action :set_service, only: [:edit, :update, :destroy]

  def index
    @services = current_user.services
  end

  def new
    @service = Service.new
  end

  def edit
  end

  def create
    @service = current_user.services.build(service_params)

    if @service.save
      GeocodeJob.perform_async(@service.id, "Service")
      redirect_to edit_dashboard_service_path(@service),
                  notice: I18n.t(:post_saved)
    else
      flash.now[:alert] = I18n.t(:post_not_saved)
      render :new
    end
  end

  def update
    if @service.update(service_params)
      GeocodeJob.perform_async(@service.id, "Service") if address_changed?
      redirect_to edit_dashboard_service_path(@service),
                  notice: I18n.t(:post_saved)
    else
      flash.now[:alert] = I18n.t(:post_not_saved)
      render :edit
    end
  end

  def destroy
    @service.destroy
    redirect_to dashboard_services_url,
                notice: I18n.t(:post_removed)
  end

  private

  def address_changed?
    return true if @service.street != service_params[:street]
    return true if @service.state != service_params[:state]
    return true if @service.city != service_params[:city]
  end

  def set_service
    @service = Service.find(params[:id])
  end

  def service_params
    params.require(:service).permit(:title,
                                    :street,
                                    :phone,
                                    :email,
                                    :site,
                                    :description,
                                    :active,
                                    :state_id,
                                    :city_id,
                                    :logo,
                                    :category,
                                    :subcategory)
  end
end
