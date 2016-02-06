FactoryGirl.define do
  factory :post do
    title { Faker::Lorem.sentence 2 }
    text { Faker::Lorem.paragraph 40 }
    category NEWS_CATEGORIES.keys.sample
    subcategory ""

    association :user

    trait :real_estate do
      category "real_estate"
      subcategory "lend"
    end
    trait :main do
      main true
    end
    trait :show_on_homepage do
      show_on_homepage true
    end
  end
end
