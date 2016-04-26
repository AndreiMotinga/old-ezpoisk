FactoryGirl.define do
  factory :plan do
    trait :basic_monthly do
      title "basic_monthly"
      name "Basic Monthly Plan"
      amount 80_00
      currency "usd"
      interval "month"
    end

    trait :basic_yearly do
      title "basic_yearly"
      name "Basic Yearly Plan"
      amount 600_00
      currency "usd"
      interval "year"
    end
  end
end
