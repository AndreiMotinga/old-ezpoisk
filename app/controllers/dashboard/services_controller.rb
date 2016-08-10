class Dashboard::ServicesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_service, only: [:edit, :update, :destroy]

  def new
    @service = Service.new(state_id: current_user.state_id,
                           city_id: current_user.city_id,
                           phone: current_user.phone,
                           email: current_user.email)
  end

  def edit
    @plans = StripePlan.all
  end

  def create
    @service = current_user.services.build(service_params)
    if @service.save
      run_jobs_and_notifications
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
      @service.entry.try(:touch)
      redirect_to edit_dashboard_service_path(@service),
                  notice: I18n.t(:post_saved)
    else
      flash.now[:alert] = I18n.t(:post_not_saved)
      render :edit
    end
  end

  def destroy
    @service.cancel
    @service.destroy
    redirect_to dashboard_path, notice: I18n.t(:post_removed)
  end

  private

  def run_jobs_and_notifications
    SlackNotifierJob.perform_async(@service.id, "Service")
    GeocodeJob.perform_async(@service.id, "Service")
    @service.create_entry(user: current_user)
  end

  def set_service
    @service = current_user.services.find(params[:id])
  end

  def service_params
    params.require(:service).permit(
      :title, :street, :phone, :fax, :email, :site, :description, :state_id,
      :city_id, :logo, :category, :active, :subcategory
    )
  end
end
