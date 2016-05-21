category = SERVICE_CATEGORIES.keys.sample
subcategory = SERVICE_CATEGORIES[category].sample

FactoryGirl.define do
  factory :service do
    title { Faker::Name.title }
    street { Faker::Address.street_name }
    phone "1234567890"
    email { Faker::Internet.email }
    state_id 32

    site { Faker::Internet.url("example.com") }
    description { Faker::Lorem.paragraph(5) }
    lat { Faker::Address.latitude }
    lng { Faker::Address.longitude }
    zip { Faker::Address.zip }
    active true

    category { category }
    subcategory { subcategory }

    association :user
    association :city

    trait :re_agency do
      category "Недвижимость"
      subcategory "Агентства Недвижимости"
    end

    trait :re_finance do
      category "Недвижимость"
      subcategory "Финансирование"
    end

    trait :job_agency do
      category "Работа"
      subcategory "Агентства по Трудоустройству"
    end
  end
end
