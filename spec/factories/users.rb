FactoryGirl.define do
  factory :user do
    email { Faker::Internet.email }
    password "password"
    password_confirmation "password"
    name { Faker::Name.name }
    phone { Faker::PhoneNumber.cell_phone }

    association :state
    association :city

    trait :admin do
      admin true
    end
  end
end
