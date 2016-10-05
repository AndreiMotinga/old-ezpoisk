FactoryGirl.define do
  factory :review do
    text { Faker::Lorem.sentence(5) }

    service
    user
  end
end
