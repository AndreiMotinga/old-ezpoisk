FactoryGirl.define do
  factory :user do
    email { Faker::Internet.email }
    password "password"
    password_confirmation "password"
    name { Faker::Name.name }
    last_seen { Time.zone.now }

    trait :admin do
      admin true
    end
  end
end
