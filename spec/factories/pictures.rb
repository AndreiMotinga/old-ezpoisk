FactoryGirl.define do
  factory :picture do
    trait :re_private do
      imageable_type "RePrivate"
    end

    trait :re_commercial do
      imageable_type "ReCommercial"
    end
  end
end
