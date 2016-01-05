FactoryGirl.define do
  factory :post do
    title { Faker::Lorem.sentence 2 }
    body { Faker::Lorem.paragraph 40 }
    category "news"

    trait :real_estate do
      category "real_estate"
      subcategory "lend"
    end

    trait :politics do
      category "politics"
    end

    trait :sport do
      category "sport"
    end
  end
end
