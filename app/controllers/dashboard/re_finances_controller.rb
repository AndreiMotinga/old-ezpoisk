class Dashboard::ReFinancesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_re_finance, only: [:edit, :update, :destroy]

  def new
    @re_finance = ReFinance.new state_id: current_user.state_id,
                              city_id: current_user.city_id,
                              active: true,
                              phone: current_user.phone,
                              email: current_user.email
  end

  def edit
  end

  def create
    @re_finance = current_user.re_finances.build(re_finance_params)

    if @re_finance.save
      SlackNotifierJob.perform_async(@re_finance.id, "ReFinance")
      AdminMailerJob.perform_async(@re_finance.id, "ReFinance")
      GeocodeJob.perform_async(@re_finance.id, "ReFinance")
      redirect_to edit_dashboard_re_finance_path(@re_finance),
                  notice: I18n.t(:post_saved)
    else
      flash.now[:alert] = I18n.t(:post_not_saved)
      render :new
    end
  end

  def update
    address_changed = address_changed?(@re_finance, re_finance_params)
    if @re_finance.update(re_finance_params)
      GeocodeJob.perform_async(@re_finance.id, "ReFinance") if address_changed
      redirect_to edit_dashboard_re_finance_path(@re_finance),
                  notice: I18n.t(:post_saved)
    else
      flash.now[:alert] = I18n.t(:post_not_saved)
      render :edit
    end
  end

  def destroy
    @re_finance.destroy if @re_finance.user == current_user
    redirect_to dashboard_path,
                notice: I18n.t(:post_removed)
  end

  private

  def set_re_finance
    @re_finance = current_user.re_finances.find(params[:id])
  end

  def re_finance_params
    params.require(:re_finance).permit(:title,
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
                                       :user_id)
  end
end
