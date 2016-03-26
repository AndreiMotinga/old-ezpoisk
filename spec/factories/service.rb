category = SERVICE_CATEGORIES.keys.sample
subcategory = SERVICE_CATEGORIES[category].second

FactoryGirl.define do
  factory :service do
    title { Faker::Name.title }
    street { Faker::Address.street_name }
    phone '1234567890'
    email { Faker::Internet.email }

    site { Faker::Internet.url("example.com") }
    description { Faker::Lorem.paragraph(5) }
    lat { Faker::Address.latitude }
    lng { Faker::Address.longitude }
    zip { Faker::Address.zip }

    category { category }
    subcategory { subcategory }

    short_description "All aboard"

    association :user
    association :state
    association :city

    trait :active do
      active true
    end
  end
end
