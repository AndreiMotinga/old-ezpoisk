FactoryGirl.define do
  factory :job do
    title { Faker::Name.title }
    phone '1234567890'
    email { Faker::Internet.email }
    description { Faker::Lorem.paragraph(5) }

    lat { Faker::Address.latitude }
    lng { Faker::Address.longitude }
    zip { Faker::Address.zip }

    post_type { JOB_TYPES.sample }
    category { JOB_CATEGORIES.first }

    association :user
    association :state
    association :city

    trait :active do
      active true
    end
  end
end
