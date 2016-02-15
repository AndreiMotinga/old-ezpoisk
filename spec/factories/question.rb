FactoryGirl.define do
  factory :question do
    title { Faker::Name.title }
    text { Faker::Lorem.paragraph(20) }
    association :user
  end
end
