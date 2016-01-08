FactoryGirl.define do
  factory :job do
    title { Faker::Name.title }
    phone { Faker::PhoneNumber.phone_number }
    email { Faker::Internet.email }
    description { Faker::Lorem.paragraph(5) }

    lat { Faker::Address.latitude }
    lng { Faker::Address.longitude }
    zip { Faker::Address.zip }

    post_type { %w(требуется ищу).sample }
    category { JOB_CATEGORIES.first }

    association :user
    association :state
    association :city

    trait :active do
      active true
    end
  end
end
