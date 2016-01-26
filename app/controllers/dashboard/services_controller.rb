class Dashboard::ServicesController < ApplicationController
  layout "dashboard"
  before_action :authenticate_user!
  before_action :set_service, only: [:edit, :update, :destroy]

  def index
    @services = current_user.services.page params[:page]
  end

  def new
    @service = Service.new state_id: current_user.state_id,
                           city_id: current_user.city_id,
                           active: true,
                           phone: current_user.phone,
                           email: current_user.email
  end

  def edit
    redirect_to dashboard_path if @service.user != current_user
  end

  def create
    @service = current_user.services.build(service_params)

    if @service.save
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
    return unless @service.user == current_user
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
    return unless @service.user == current_user
    @service.destroy
    redirect_to dashboard_services_url,
                notice: I18n.t(:post_removed)
  end

  private

  def set_service
    @service = Service.find(params[:id])
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
                                    :slug,
                                    :category,
                                    :subcategory)
  end
end
