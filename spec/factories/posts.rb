FactoryGirl.define do
  factory :post do
    title { Faker::Lorem.sentence 2 }
    body { Faker::Lorem.paragraph 40 }
    category NEWS_CATEGORIES.sample
    subcategory ""
    logo "http://images5.fanpop.com/image/photos/29200000/Obama-barack-obama-29238444-1280-800.jpg"
    important true

    association :user

    trait :real_estate do
      category "real_estate"
      subcategory "lend"
    end
  end
end
