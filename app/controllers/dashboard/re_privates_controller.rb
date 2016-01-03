class Dashboard::RePrivatesController < ApplicationController
  layout "dashboard"
  before_action :authenticate_user!
  before_action :set_re_private, only: [:edit, :update, :destroy]

  def index
    @re_privates = current_user.re_privates
  end

  def new
    @re_private = RePrivate.new
  end

  def edit
  end

  def create
    @re_private = current_user.re_privates.build(re_private_params)

    if @re_private.save
      GeocodeJob.perform_async(@re_private.id, "RePrivate")
      redirect_to edit_dashboard_re_private_path(@re_private),
                  notice: I18n.t(:post_saved)
    else
      flash.now[:alert] = I18n.t(:post_not_saved)
      render :new
    end
  end

  def update
    if @re_private.update(re_private_params)
      GeocodeJob.perform_async(@re_private.id, "RePrivate") if address_changed?
      redirect_to edit_dashboard_re_private_path(@re_private),
                  notice: I18n.t(:post_saved)
    else
      flash.now[:alert] = I18n.t(:post_not_saved)
      render :edit
    end
  end

  def destroy
    @re_private.destroy
    redirect_to dashboard_re_privates_path,
                notice: I18n.t(:post_removed)
  end

  private

  def set_re_private
    @re_private = RePrivate.find(params[:id])
  end

  def address_changed?
    return true if @re_private.street != re_private_params[:street]
    return true if @re_private.state != re_private_params[:state]
    return true if @re_private.city != re_private_params[:city]
  end

  def re_private_params
    params.require(:re_private).permit(:street,
                                       :post_type,
                                       :duration,
                                       :apt,
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
