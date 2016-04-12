class Dashboard::RePrivatesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_re_private, only: [:edit, :update, :destroy]

  def new
    @re_private = RePrivate.new state_id: current_user.state_id,
                                city_id: current_user.city_id,
                                active: true,
                                email: current_user.email,
                                fee: true,
                                baths: 1,
                                duration: "помесячно",
                                phone: current_user.phone
  end

  def edit
  end

  def create
    @re_private = current_user.re_privates.build(re_private_params)

    if @re_private.save
      SlackNotifierJob.perform_async(@re_private.id, "RePrivate")
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
    @re_private.destroy if @re_private.user == current_user
    redirect_to dashboard_path,
                notice: I18n.t(:post_removed)
  end

  private

  def set_re_private
    @re_private = current_user.re_privates.find(params[:id])
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
                                       :source,
                                       :email,
                                       :city_id)
  end
end
