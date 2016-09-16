FactoryGirl.define do
  factory :post do
    title "Sample title for post"
    text { Faker::Lorem.paragraph 40 }
    summary { Faker::Lorem.paragraph 5 }
    category 'user'

    user
  end
end
