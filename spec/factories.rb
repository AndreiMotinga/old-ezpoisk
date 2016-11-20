FactoryGirl.define do
  factory :answer do
    title { Faker::Lorem.paragraph }
    text { Faker::Lorem.paragraph(20) }

    question
    user
  end

  factory :comment do
    text { Faker::Lorem.paragraph }
    association :commentable, factory: :re_private
    user
  end

  factory :favorite do
    trait :saved do
      saved true
      hidden false
    end
  end

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

  factory :partner do
    title { Faker::Lorem.sentence.truncate(45) }
    text { Faker::Lorem.sentence.truncate(45) }
    url "//google.com?image=#{(1..10).to_a.sample}"
    position { %w(left right).sample }
    budget { Faker::Number.number(2).to_i }
    phone "1234567890"
    email { Faker::Internet.email }
    image {
      Rack::Test::UploadedFile.new(
        "#{Rails.root}/spec/support/fixtures/#{(1..10).to_a.sample}.jpg",
        "image/png"
      )
    }
    user
  end

  factory :post do
    title "Sample title for post"
    text { Faker::Lorem.paragraph 40 }
    summary { Faker::Lorem.paragraph 5 }
    category "user"
    user
  end

  factory :re_private do
    price { rand(2000) }
    phone "1234567890"
    baths { Faker::Number.number(1).to_i }
    space { Faker::Number.number(4).to_i }
    active true
    text { Faker::Lorem.sentence(5) }
    street { Faker::Address.street_name }
    rooms { RePrivate::ROOMS.sample }
    category { RePrivate::CATEGORIES.sample }
    post_type { RePrivate::TYPES.sample }
    duration { RePrivate::DURATION.sample }
    fee { [true, false].sample }
    state_id 33
    city_id 18_031
    email { Faker::Internet.email }
    vk "https://vk.com/id129328692"
    fb "https://www.facebook.com/101"
    user

    trait :with_geolocation do
      lat { Faker::Address.latitude }
      lng { Faker::Address.longitude }
      zip { Faker::Address.zip }
    end
  end

  factory :review do
    text { Faker::Lorem.sentence(5) }
    service
    user
  end

  factory :sale do
    title { Faker::Name.title }
    phone "1234567890"
    email { Faker::Internet.email }
    category { Sale::CATEGORIES.sample }
    state_id 33
    city_id 18_031
    post_type { %w(buying selling giving).sample }
    text { Faker::Lorem.paragraph(5) }
    vk "https://vk.com/id129328692"
    fb "https://www.facebook.com/101"
    active true
  end

  factory :service do
    title { Faker::Name.title }
    street { Faker::Address.street_name }
    phone "1234567890"
    email { Faker::Internet.email }
    state_id 33
    city_id 18031
    active true
    site { Faker::Internet.url("example.com") }
    text { Faker::Lorem.paragraph(5) }
    category { Service::SUBCATEGORIES.keys.sample }
    subcategory { Service::SUBCATEGORIES[category].sample }
    vk { Faker::Internet.email }
    fb { Faker::Internet.email }
    ok { Faker::Internet.email }
    google { Faker::Internet.email }
    twitter { Faker::Internet.email }
    user
  end

  factory :user do
    email { Faker::Internet.email }
    name { Faker::Name.name }
  end

  factory :question do
    title { Faker::Name.title }
    text { Faker::Lorem.paragraph(20) }
    tag_list ["auto"]
  end
end
