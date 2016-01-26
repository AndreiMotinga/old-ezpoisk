class Dashboard::RePrivatesController < ApplicationController
  layout "dashboard"
  before_action :authenticate_user!
  before_action :set_re_private, only: [:edit, :update, :destroy]

  def index
    @re_privates = current_user.re_privates.page params[:page]
  end

  def new
    @re_private = RePrivate.new state_id: current_user.state_id,
                                city_id: current_user.city_id,
                                phone: current_user.phone
  end

  def edit
    redirect_to dashboard_path if @re_private.user != current_user
  end

  def create
    @re_private = current_user.re_privates.build(re_private_params)

    if @re_private.save
      AdminMailerJob.perform_async(@re_private.id, "RePrivate")
      GeocodeJob.perform_async(@re_private.id, "RePrivate")
      redirect_to edit_dashboard_re_private_path(@re_private),
                  notice: I18n.t(:post_saved)
    else
      flash.now[:alert] = I18n.t(:post_not_saved)
      render :new
    end
  end

  def update
    return unless @re_private.user == current_user
    address_changed = address_changed?(@re_private, re_private_params)
    if @re_private.update(re_private_params)
      GeocodeJob.perform_async(@re_private.id, "RePrivate") if address_changed
      redirect_to edit_dashboard_re_private_path(@re_private),
                  notice: I18n.t(:post_saved)
    else
      flash.now[:alert] = I18n.t(:post_not_saved)
      render :edit
    end
  end

  def destroy
    return unless @re_private.user == current_user
    @re_private.destroy if @re_private.user == current_user
    redirect_to dashboard_re_privates_path,
                notice: I18n.t(:post_removed)
  end

  private

  def set_re_private
    @re_private = RePrivate.find(params[:id])
  end

  def re_private_params
    params.require(:re_private).permit(:street,
                                       :post_type,
                                       :duration,
                                       :phone,
                                       :price,
                                       :baths,
                                       :space,
                                       :rooms,
                                       :active,
                                       :fee,
                                       :description,
                                       :state_id,
                                       :city_id)
  end
end
