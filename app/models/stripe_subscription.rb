class StripeSubscription < ActiveRecord::Base
  include Stripe::Callbacks

  belongs_to :service
  validates :service_id, presence: true
  validates :service, uniqueness: true

  after_invoice_payment_succeeded! do |invoice, _event|
    sub = StripeSubscription.find_by_customer_id(invoice.customer)
    sub.update_attributes(
      active_until: 1.month.from_now,
      status: "activated"
    )
  end

  after_invoice_payment_failed! do |invoice, _event|
    # todo send email when customer is deleted
    # todo send notification to slack
    StripeSubscription.find_by_customer_id(invoice.customer).destroy
    Stripe::Customer.retrieve(invoice.customer).delete
  end

  def cancel
    remote_sub.delete(at_period_end: true)
    update_attribute(:status, "cancelled")
  end

  def cancelled?
    active? && status == "cancelled"
  end

  def active?
    active_until.future?
  end

  def activated?
    status == "activated"
  end

  def reactivate
    stripe_sub = remote_sub
    stripe_sub.plan = plan
    stripe_sub.save
    update_attribute(:status, "activated")
  end

  def remote_sub
    customer = Stripe::Customer.retrieve(customer_id)
    customer.subscriptions.retrieve(sub_id)
  end
end
