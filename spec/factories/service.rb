FactoryGirl.define do
  factory :service do
    title { Faker::Name.title }
    street { Faker::Address.street_name }
    phone "1234567890"
    email { Faker::Internet.email }
    state_id 32
    city_id 18031
    active true

    site { Faker::Internet.url("example.com") }
    text { Faker::Lorem.paragraph(5) }
    lat { Faker::Address.latitude }
    lng { Faker::Address.longitude }
    zip { Faker::Address.zip }

    category { SERVICE_SUBCATEGORIES.keys.sample }
    subcategory { SERVICE_SUBCATEGORIES[category].sample }

    vk { Faker::Internet.email }
    fb { Faker::Internet.email }
    ok { Faker::Internet.email }
    google { Faker::Internet.email }
    twitter { Faker::Internet.email }

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

    trait :with_logo do
      logo {
        Rack::Test::UploadedFile.new(
          "#{Rails.root}/spec/support/fixtures/#{(1..10).to_a.sample}.jpg",
          "image/png"
        )
      }
    end
  end
end
