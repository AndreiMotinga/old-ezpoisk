class Dashboard::ServicesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_service, only: [:edit, :update, :destroy, :payment]
  before_action :set_plan, only: [:payment]

  def new
    @service = Service.new(state_id: current_user.profile.state_id,
                           city_id: current_user.profile.city_id,
                           phone: current_user.profile.phone,
                           email: current_user.email)
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

  def payment
    begin
      process_payment
      Ez.ping("!!!!!!!!!!!!! вам заплатили")
      flash[:notice] = "Объявление успешно оплачено"
    rescue => error
      flash[:alert] = error.message
    end
    redirect_to edit_dashboard_service_path(@service)
  end

  def destroy
    @service.destroy
    redirect_to dashboard_path, notice: I18n.t(:post_removed)
  end

  private

  def process_payment
    customer = Stripe::Customer.create(source:  params[:stripeToken],
                                       plan: @plan.title,
                                       email: current_user.email)
    @service.create_stripe_subscription(stripe_id: customer.id)
    @service.extend(@plan.extension_period)
  end

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
                                    :state_id,
                                    :city_id,
                                    :logo,
                                    :category,
                                    :subcategory)
  end

  def set_plan
    @plan = Plan.find_by_title(params[:plan])
  end
end
