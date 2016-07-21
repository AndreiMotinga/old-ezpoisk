FactoryGirl.define do
  factory :stripe_subscription do
    # sub_id "foo"
    # customer_id "bar"
    active_until { 1.month.from_now }
    status "activated"

    service
  end
end
