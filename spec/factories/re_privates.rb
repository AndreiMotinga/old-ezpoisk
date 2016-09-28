FactoryGirl.define do
  factory :re_private do
    price { rand(2000) }
    phone "1234567890"
    baths { Faker::Number.number(1).to_i }
    space { Faker::Number.number(4).to_i }
    active true
    text { Faker::Lorem.sentence(5) }
    street { Faker::Address.street_name }
    rooms { RePrivate::ROOMS.sample }
    category { RePrivate::CATEGORIES.sample }
    post_type { RePrivate::TYPES.sample }
    duration { RePrivate::DURATION.sample }
    fee { [true, false].sample }
    state_id 32
    city_id 18_031
    email { Faker::Internet.email }
    vk "https://vk.com/id129328692"
    fb "https://www.facebook.com/101"

    trait :with_geolocation do
      lat { Faker::Address.latitude }
      lng { Faker::Address.longitude }
      zip { Faker::Address.zip }
    end
  end
end
