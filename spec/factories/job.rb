FactoryGirl.define do
  factory :job do
    title { Faker::Name.title }
    phone "1234567890"
    email { Faker::Internet.email }
    text { Faker::Lorem.paragraph(5) }
    category { JOB_CATEGORIES.sample }
    active true
    lat { Faker::Address.latitude }
    lng { Faker::Address.longitude }
    zip { Faker::Address.zip }
    vk { Faker::Internet.email }
    fb { Faker::Internet.email }

    state_id 32
    city_id 18_031

    user
  end
end
