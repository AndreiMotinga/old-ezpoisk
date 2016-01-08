FactoryGirl.define do
  factory :comment do
    body { Faker::Lorem.paragraph(5) }
    association :user
    association :post
  end
end
