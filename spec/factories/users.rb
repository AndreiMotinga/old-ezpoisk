FactoryGirl.define do
  factory :user do
    email { Faker::Internet.email }
    password "password"
    password_confirmation "password"
    name { Faker::Name.name }
    phone '1234567890'

    association :state
    association :city

    trait :admin do
      admin true
    end
  end
end
