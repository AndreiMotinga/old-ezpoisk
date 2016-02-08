FactoryGirl.define do
  factory :re_commercial do
    category { RE_COMMERCIAL_CATEGORIES.sample }
    price { rand(2000) }
    space { Faker::Number.number(4).to_i }
    lat { Faker::Address.latitude }
    lng { Faker::Address.longitude }
    active { [true, false].sample }
    description { Faker::Lorem.sentence(5) }
    street { Faker::Address.street_name }
    post_type { RE_TYPES.sample }
    zip { Faker::Address.zip }
    phone '1234567890'

    association :user
    association :state
    association :city

    trait :active do
      active true
    end
  end
end
