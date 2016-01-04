FactoryGirl.define do
  factory :re_private do
    price { rand(2000) }
    phone { Faker::PhoneNumber.cell_phone }
    baths { Faker::Number.number(1).to_i }
    space { Faker::Number.number(4).to_i }
    active { [true, false].sample }
    description { Faker::Lorem.sentence(5) }
    street { Faker::Address.street_name }
    apt { Faker::Address.secondary_address }
    rooms { (1..5).to_a.sample }
    post_type { %w(продажа аренда).sample }
    duration { %w(почасово посуточно помесячно).sample }
    lat { Faker::Address.latitude }
    lng { Faker::Address.longitude }
    zip { Faker::Address.zip }
    fee { [true, false].sample }

    association :user
    association :state
    association :city

    trait :active do
      active true
    end
  end
end
