class Dashboard::ServicesController < ApplicationController
  before_action :set_service, only: [:edit, :update, :destroy]

  def new
    @service = Service.new(state_id: current_user.try(:state_id),
                           city_id: current_user.try(:city_id),
                           phone: current_user.try(:phone),
                           active: true,
                           email: current_user.try(:email))
  end

  def edit
    @plans = StripePlan.all
  end

  def create
    @service = Service.new(service_params)
    @service.user = current_user
    if @service.save
      run_create_notifications
      redirect_on_create
    else
      flash.now[:alert] = I18n.t(:post_not_saved)
      render :new
    end
  end

  def update
    address_changed = address_changed?(@service, service_params)
    if @service.update(service_params)
      GeocodeJob.perform_async(@service.id, "Service") if address_changed
      run_update_notifications
      redirect_to update_redirect_path, notice: I18n.t(:post_saved)
    else
      flash.now[:alert] = I18n.t(:post_not_saved)
      render :edit
    end
  end

  def destroy
    @service.cancel
    @service.destroy
    redirect_to destroy_redirect_path, notice: I18n.t(:post_removed)
  end

  private

  def redirect_on_create
    if @service.user
      redirect_to(
        edit_dashboard_service_path(@service),
        notice: I18n.t(:post_created)
      )
    else
      redirect_to(
        edit_dashboard_service_path(@service, token: @service.token),
        notice: I18n.t(:post_created_wr)
      )
    end
  end

  def update_redirect_path
    if params[:token].present?
      edit_dashboard_service_path(@service, token: params[:token])
    else
      edit_dashboard_service_path(@service)
    end
  end

  def run_update_notifications
    @service.entry.try(:touch)
    unless current_user.try(:team_member?)
      SlackNotifierJob.perform_async(@service.id, "Service", 'update')
    end
  end

  def run_create_notifications
    SlackNotifierJob.perform_async(@service.id, "Service")
    GeocodeJob.perform_async(@service.id, "Service")
    FacebookNotifierJob.perform_in(18.minutes, @service.id, "Service")
    VkNotifierJob.perform_in(17.minutes, @service.id, "Service")
    @service.create_entry(user: current_user)
  end

  def set_service
    if params[:token].present?
      @service = Service.find(params[:id])
      @service = nil unless @service.token == params[:token]
    else
      @service = current_user.services.find(params[:id])
    end
  end

  def service_params
    params.require(:service).permit(
      :title, :street, :phone, :fax, :email, :site, :description, :state_id,
      :city_id, :logo, :category, :active, :subcategory
    )
  end
end
