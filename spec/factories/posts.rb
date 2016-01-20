FactoryGirl.define do
  factory :post do
    title { Faker::Lorem.sentence 2 }
    body { Faker::Lorem.paragraph 40 }
    category NEWS_CATEGORIES.keys.sample
    subcategory ""
    logo "http://images5.fanpop.com/image"
    important true
    from_rss false
    description { Faker::Lorem.paragraph 4 }

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
