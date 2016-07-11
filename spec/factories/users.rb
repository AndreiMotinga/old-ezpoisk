FactoryGirl.define do
  factory :user do
    email { Faker::Internet.email }
    password "password"
    password_confirmation "password"
    name { Faker::Name.name }

    trait :admin do
      admin true
    end

    after(:create) do |user|
      create(:profile, user: user)
    end
  end
end
