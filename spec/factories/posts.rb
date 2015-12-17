FactoryGirl.define do
  factory :post do
    title { Faker::Lorem.sentence 2 }
    body { Faker::Lorem.paragraph 40 }
    category "news"

    trait :real_estate do
      category "real_estate"
      subcategory "lend"
    end
  end
end
