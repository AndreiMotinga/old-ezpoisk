FactoryGirl.define do
  factory :review do
    rating { rand (1..5) }
    text { Faker::Lorem.sentence(5) }

    service
    user
  end
end
