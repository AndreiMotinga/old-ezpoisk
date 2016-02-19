FactoryGirl.define do
  factory :re_finance do
    title { Faker::Name.title }
    street { Faker::Address.street_name }
    phone '1234567890'
    fax { Faker::PhoneNumber.phone_number }
    email { Faker::Internet.email }
    site { Faker::Internet.url("example.com") }
    description { Faker::Lorem.paragraph(5) }
    lat{ Faker::Address.latitude }
    lng{ Faker::Address.longitude }
    zip { Faker::Address.zip }
    active true

    association :user
    association :state
    association :city

  end
end
