FactoryGirl.define do
  factory :sale do
    title { Faker::Name.title }
    phone "1234567890"
    email { Faker::Internet.email }
    category { Sale::CATEGORIES.sample}
    state_id 33
    city_id 18031
    post_type { %w(buying selling giving).sample }

    text { Faker::Lorem.paragraph(5) }
    vk "https://vk.com/id129328692"
    fb "https://www.facebook.com/101"

    trait :active do
      active true
    end
  end
end
