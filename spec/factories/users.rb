FactoryGirl.define do
  factory :user do
    email { Faker::Internet.email }
    password "password"
    password_confirmation "password"

    association :profile

    trait :admin do
      admin true
    end
  end
end
