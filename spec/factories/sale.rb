FactoryGirl.define do
  factory :sale do
    title { Faker::Name.title }
    phone "1234567890"
    email { Faker::Internet.email }
    category { SALE_CATEGORIES.sample}
    state_id 32
    city_id 18031

    text { Faker::Lorem.paragraph(5) }
    lat { Faker::Address.latitude }
    lng { Faker::Address.longitude }
    zip { Faker::Address.zip }
    vk "https://vk.com/id129328692"
    fb "https://www.facebook.com/101"

    trait :active do
      active true
    end
  end
end
