class StripeSubscriptionsController < ApplicationController
  def create
    begin
      create_or_update_subscription
      flash[:notice] = I18n.t(:stripe_subscription_created)
    rescue => err
      flash[:alert] = err.message
    end
    redirect_to edit_dashboard_service_path(params[:service_id])
  end

  def update
    sub = current_user.stripe_subscriptions.find(params[:id])
    begin
      sub.reactivate
      flash[:notice] = I18n.t(:stripe_subscription_renewed)
    rescue => err
      flash[:alert] = err.message
    end
    redirect_to edit_dashboard_service_path(sub.service)
  end

  def destroy
    sub = current_user.stripe_subscriptions.find(params[:id])
    begin
      sub.cancel
      flash[:notice] = I18n.t(:stripe_subscription_cancelled)
    rescue => err
      flash[:alert] = err.message
    end
    redirect_to edit_dashboard_service_path(sub.service)
  end

  private

  def create_or_update_subscription
    id = params[:service_id]
    sub = current_user.stripe_subscriptions.find_by_service_id(id)
    if sub
      sub.update_attributes(attributes)
    else
      StripeSubscription.create(attributes)
    end
  end

  def attributes
    {
      # activate listing temporarily. invoice.payment_succeeded will trigger
      # webhook, that will be cought at StripeSubscription, where actvie_until
      # will be set to 1.month.from_now
      active_until: 1.month.from_now,
      status: "activated",
      service_id: params[:service_id],
      customer_id: customer.id,
      sub_id: customer.subscriptions.data.first.id
    }
  end

  def customer
    @customer ||= Stripe::Customer.create(source:  params[:stripeToken],
                                          plan: params[:plan],
                                          email: params[:stripeEmail])
  end
end
