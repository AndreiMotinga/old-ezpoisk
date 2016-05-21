FactoryGirl.define do
  factory :job do
    title { Faker::Name.title }
    phone '1234567890'
    email { Faker::Internet.email }
    description { Faker::Lorem.paragraph(5) }
    state_id 32
    city_id 18031

    lat { Faker::Address.latitude }
    lng { Faker::Address.longitude }
    zip { Faker::Address.zip }

    category { JOB_CATEGORIES.first }

    association :user

    trait :active do
      active true
    end
  end
end
