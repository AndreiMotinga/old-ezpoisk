class Dashboard::ChargesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_partner

  def new
  end

  def week
    do_proccessing(1)
  end

  def biweek
    do_proccessing(2)
  end

  def quadroweek
    do_proccessing(4)
  end

  private

  def do_proccessing(weeks)
    token = params[:stripeToken]
    begin
      charge_user(token, weeks)
      @partner.activate(weeks)
      SlackNotifierJob.perform_async(@partner.id, "Partner")
      redirect_to dashboard_partners_path
    rescue Stripe::CardError => e
      flash[:alert] = "Платеж не удался, попробуйте другую карту. Ошибка: #{e.message}"
      render :new
    end
  end

  def charge_user(token, weeks)
    Stripe::Charge.create(
      amount: @partner.amount_to_pay(weeks, current_user),
      currency: "usd",
      receipt_email: current_user.email,
      source: token,
      description: "Оплата банера."
    )
  end

  def set_partner
    @partner = current_user.partners.find(params[:partner_id])
  end
end
