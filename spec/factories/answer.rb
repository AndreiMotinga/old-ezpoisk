FactoryGirl.define do
  factory :answer do
    text { Faker::Lorem.paragraph(20) }

    trait :with_question do
      question
    end

    trait :with_user do
      user
    end
  end
end
