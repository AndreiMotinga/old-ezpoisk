class StripeSubscription < ActiveRecord::Base
  include Stripe::Callbacks
  before_destroy :cancel_subscription
  belongs_to :payable, polymorphic: true

  after_invoice_payment_succeeded! do |invoice, event|
    sub = find_by_stripe_id(invoice.customer)
    plan = Plan.find_by_title(invoice.lines.data.first.plan.id)
    sub.payable.extend(plan.extension_period)
  end

  private

  def cancel_subscription
    customer = Stripe::Customer.retrieve(stripe_id)
    customer.delete
  end
end
