FactoryGirl.define do
  factory :post do
    title { Faker::Lorem.sentence 2 }
    text { Faker::Lorem.paragraph 40 }
    summary { Faker::Lorem.paragraph 4 }
    category 'user'
  end
end
