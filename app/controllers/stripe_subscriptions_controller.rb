class StripeSubscriptionsController < ApplicationController
  def create
    begin
      StripeSubscription.create(attributes)
      update_service_priority
      flash[:notice] = I18n.t(:stripe_subscription_created)
    rescue => err
      flash[:alert] = err.message
    end
    redirect_to edit_dashboard_service_path(params[:service_id])
  end

  # reactivates cancelled subscription
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

  def update_service_priority
    plan = StripePlan.find_by_stripe_id(params[:plan])
    Service.find(params[:service_id]).update_column(:priority, plan.priority)
  end

  def attributes
    {
      active_until: 1.month.from_now,
      status: "activated",
      plan: params[:plan],
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
