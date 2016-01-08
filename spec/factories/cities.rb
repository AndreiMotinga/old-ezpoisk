FactoryGirl.define do
  factory :city do
    name "Ataki"

    trait :brooklyn do
      name "Brooklyn"
    end

    trait :abbeville do
      name "Abbeville"
    end
  end
end
