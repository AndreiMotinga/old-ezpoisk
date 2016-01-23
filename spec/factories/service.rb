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

    # TODO: fix?
    # logo_file_name "97ca280e9fff23110bc5fbab1ada1.jpg"
    # logo_content_type "image/jpeg"
    # logo_file_size 867_67
    # logo_updated_at "Fri, 08 Jan 2016 18:02:01 UTC +00:00"

    association :user
    association :state
    association :city

    trait :active do
      active true
    end
  end
end
