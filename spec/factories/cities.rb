FactoryGirl.define do
  factory :city do
    name "Ataki"
    state_id 32

    # todo remvoe

    trait :brooklyn do
      name "Brooklyn"
    end

    trait :abbeville do
      name "Abbeville"
    end
  end
end
