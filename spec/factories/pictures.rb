FactoryGirl.define do
  factory :picture do
    trait :re_private do
      imageable_type "RePrivate"
    end
  end
end
