class Dashboard::RePrivatesController < ApplicationController
  before_action :set_re_private, only: [:edit, :update, :destroy]

  def new
    @re_private = RePrivate.new(state_id: current_user.try(:state_id),
                                city_id: current_user.try(:city_id),
                                active: true,
                                email: current_user.try(:new_email),
                                baths: 1,
                                duration: "помесячно",
                                phone: current_user.try(:phone))
  end

  def edit
  end

  def create
    @re_private = RePrivate.new(re_private_params)
    @re_private.user = current_user
    if @re_private.save
      run_create_notifications
      redirect_on_create
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

  def redirect_on_create
    if @re_private.user
      redirect_to(
        edit_dashboard_re_private_path(@re_private),
        notice: I18n.t(:post_created)
      )
    else
      redirect_to(
        edit_dashboard_re_private_path(@re_private, token: @re_private.token),
        notice: I18n.t(:post_created_wr)
      )
    end
  end

  def update_redirect_path
    if params[:token].present?
      edit_dashboard_re_private_path(@re_private, token: params[:token])
    else
      edit_dashboard_re_private_path(@re_private)
    end
  end

  def run_update_notifications
    unless current_user.try(:team_member?)
      SlackNotifierJob.perform_async(@re_private.id, "RePrivate", 'update')
    end
    @re_private.entry.try(:touch)
  end

  def run_create_notifications
    SlackNotifierJob.perform_async(@re_private.id, "RePrivate")
    GeocodeJob.perform_async(@re_private.id, "RePrivate")
    FacebookNotifierJob.perform_in(27.minutes, @re_private.id, "RePrivate")
    VkNotifierJob.perform_in(23.minutes, @re_private.id, "RePrivate")
    # todo do I still use entries it?
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
      :rooms, :active, :fee, :text, :state_id, :source, :email, :city_id,
      :category
    )
  end
end
