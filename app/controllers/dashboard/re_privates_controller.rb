class Dashboard::RePrivatesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]
  before_action :set_re_private, only: [:edit, :update, :destroy]

  def new
    @re_private = RePrivate.new(state_id: current_user.state_id,
                                city_id: current_user.city_id,
                                active: true,
                                email: current_user.new_email,
                                baths: 1,
                                duration: "помесячно",
                                phone: current_user.phone)
  end

  def edit
  end

  def create
    @re_private = current_user.re_privates.build(re_private_params)
    if @re_private.save
      run_create_notifications
      redirect_to edit_dashboard_re_private_path(@re_private),
                  notice: I18n.t(:post_saved)
    else
      flash.now[:alert] = I18n.t(:post_not_saved)
      render :new
    end
  end

  def update
    address_changed = address_changed?(@re_private, re_private_params)
    if @re_private.update(re_private_params)
      GeocodeJob.perform_async(@re_private.id, "RePrivate") if address_changed
      run_update_notifications
      redirect_to update_redirect_path, notice: I18n.t(:post_saved)
    else
      flash.now[:alert] = I18n.t(:post_not_saved)
      render :edit
    end
  end

  def destroy
    @re_private.destroy
    redirect_to destroy_redirect_path, notice: I18n.t(:post_removed)
  end

  private

  def update_redirect_path
    if params[:token].present?
      edit_dashboard_re_private_path(@re_private, token: params[:token])
    else
      edit_dashboard_re_private_path(@re_private)
    end
  end

  def run_update_notifications
    SlackNotifierJob.perform_async(@re_private.id, "RePrivate", 'update')
    @re_private.entry.try(:touch)
  end

  def run_create_notifications
    SlackNotifierJob.perform_async(@re_private.id, "RePrivate")
    GeocodeJob.perform_async(@re_private.id, "RePrivate")
    @re_private.create_entry(user: current_user)
    create_subscription(@re_private)
  end

  def set_re_private
    if params[:token].present?
      @re_private = RePrivate.find(params[:id])
      @re_private = nil unless @re_private.token == params[:token]
    else
      @re_private = current_user.re_privates.find(params[:id])
    end
  end

  def re_private_params
    params.require(:re_private).permit(
      :street, :post_type, :duration, :phone, :price, :baths, :space,
      :rooms, :active, :fee, :description, :state_id, :source, :email, :city_id
    )
  end
end
