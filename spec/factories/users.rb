FactoryGirl.define do
  factory :user do
    email { Faker::Internet.email }
    password "password"
    password_confirmation "password"
    name "Andrei"
    phone { Faker::PhoneNumber.cell_phone }

    #   phone { Faker::PhoneNumber.phone_number }
    #   name { Faker::Name.name }
    #   trait :admin do
    #     admin true
    #   end
  end
end
