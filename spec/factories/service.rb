category = SERVICE_CATEGORIES.keys.sample
subcategory = SERVICE_CATEGORIES[category].second

FactoryGirl.define do
  factory :service do
    title { Faker::Name.title }
    street { Faker::Address.street_name }
    phone { Faker::PhoneNumber.phone_number }
    email { Faker::Internet.email }

    site { Faker::Internet.url("example.com") }
    description { Faker::Lorem.paragraph(5) }
    lat { Faker::Address.latitude }
    lng { Faker::Address.longitude }
    zip { Faker::Address.zip }

    category { category }
    subcategory { subcategory }

    slug "All aboard"

    association :user
    association :state
    association :city

    trait :active do
      active true
    end
  end
end
