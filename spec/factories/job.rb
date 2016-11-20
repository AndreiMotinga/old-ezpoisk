FactoryGirl.define do
  factory :job do
    title { Faker::Name.title }
    phone "1234567890"
    email { Faker::Internet.email }
    text { Faker::Lorem.paragraph(5) }
    post_type { Job::TYPES.sample }
    category { Job::CATEGORIES.sample }
    active true
    vk "https://vk.com/id129328692"
    fb "https://www.facebook.com/101"

    state_id 33
    city_id 18_031
  end
end
