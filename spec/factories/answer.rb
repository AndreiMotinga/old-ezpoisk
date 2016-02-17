FactoryGirl.define do
  factory :answer do
    text { Faker::Lorem.paragraph(20) }
    association :question
    association :user
  end
end
