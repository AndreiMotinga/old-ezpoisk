FactoryGirl.define do
  factory :re_commercial do
    category { %w(office retail industrial parking other).sample }
    price { rand(2000) }
    space { Faker::Number.number(4).to_i }
    latitude { Faker::Address.latitude }
    longitude { Faker::Address.longitude }
    active { [true, false].sample }
    description { Faker::Lorem.sentence(5) }
    street { Faker::Address.street_name }
    post_type { %w(rent sale).sample }
    zip { Faker::Address.zip }
    phone { Faker::PhoneNumber.cell_phone }

    association :user
    association :state
    association :city

    trait :active do
      active true
    end
  end
end
