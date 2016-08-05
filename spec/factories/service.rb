FactoryGirl.define do
  factory :service do
    title { Faker::Name.title }
    street { Faker::Address.street_name }
    phone "1234567890"
    email { Faker::Internet.email }
    state_id 32
    city_id 18031

    site { Faker::Internet.url("example.com") }
    description { Faker::Lorem.paragraph(5) }
    lat { Faker::Address.latitude }
    lng { Faker::Address.longitude }
    zip { Faker::Address.zip }

    category { SERVICE_CATEGORIES.sample.second }
    subcategory { SERVICE_SUBCATEGORIES[category].sample.second }

    user

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

  trait :active do
    stripe_subscription
  end
end
