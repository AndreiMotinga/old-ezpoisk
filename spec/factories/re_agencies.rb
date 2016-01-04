FactoryGirl.define do
  factory :re_agency do
    title { Faker::Name.title }
    street { Faker::Address.street_name }
    phone { Faker::PhoneNumber.phone_number }
    email { Faker::Internet.email }
    site { Faker::Internet.url("example.com") }
    description { Faker::Lorem.paragraph(5) }
    lat{ Faker::Address.latitude }
    lng{ Faker::Address.longitude }
    zip { Faker::Address.zip }

    association :user
    association :state
    association :city

    trait :active do
      active true
    end
  end
end
