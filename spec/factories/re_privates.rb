FactoryGirl.define do
  factory :re_private do
    price { rand(2000) }
    phone '1234567890'
    baths { Faker::Number.number(1).to_i }
    space { Faker::Number.number(4).to_i }
    active true
    description { Faker::Lorem.sentence(5) }
    street { Faker::Address.street_name }
    rooms { ROOM_OPTIONS.sample.second }
    post_type { RE_TYPES.sample }
    duration { RE_DURATION.sample }
    fee { [true, false].sample }
    state_id 32
    city_id 18031
    email { Faker::Internet.email }

    trait :with_geolocation do
      lat { Faker::Address.latitude }
      lng { Faker::Address.longitude }
      zip { Faker::Address.zip }
    end

    user
  end
end
