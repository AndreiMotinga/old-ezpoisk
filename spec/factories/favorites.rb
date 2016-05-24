FactoryGirl.define do
  factory :favorite do
    trait :saved do
      saved true
      hidden false
    end
  end
end
