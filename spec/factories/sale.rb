category = SERVICE_CATEGORIES.keys.sample
subcategory = SERVICE_CATEGORIES[category]

FactoryGirl.define do
  factory :sale do
    title { Faker::Name.title }
    phone '1234567890'
    email { Faker::Internet.email }

    description { Faker::Lorem.paragraph(5) }
    lat { Faker::Address.latitude }
    lng { Faker::Address.longitude }
    zip { Faker::Address.zip }

    category { SALE_CATEGORIES.sample }

    association :user
    association :state
    association :city

    trait :active do
      active true
    end
  end
end
