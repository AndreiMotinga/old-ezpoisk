class Dashboard::ChargesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_partner

  def new
  end

  def week
    activate_partner(1)
  end

  def biweek
    activate_partner(2)
  end

  def quadroweek
    activate_partner(4)
  end

  private

  def activate_partner(weeks)
    token = params[:stripeToken]
    amount = PartnerChargeCalculator.new(weeks, current_user).amount_to_pay
    begin
      charge_user(token, amount)
      @partner.activate(weeks, amount)
      SlackNotifierJob.perform_async(@partner.id, "Partner")
      redirect_to dashboard_partners_path
    rescue Stripe::CardError => error
      flash.now[:alert] = "Платеж не удался, попробуйте другую карту.
                           Ошибка: #{error.message}"
      render :new
    end
  end

  def charge_user(token, amount)
    Stripe::Charge.create(
      amount: amount,
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
