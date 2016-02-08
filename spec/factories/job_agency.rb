FactoryGirl.define do
  factory :job_agency do
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

    association :user
    association :state
    association :city

    trait :active do
      active true
    end
  end
end
