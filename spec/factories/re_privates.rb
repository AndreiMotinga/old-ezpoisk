FactoryGirl.define do
  factory :re_private do
    price { rand(2000) }
    phone '34343343434'
    baths { Faker::Number.number(1).to_i }
    space {Faker::Number.number(4).to_i }
    active {[true, false].sample }
    description {Faker::Lorem.sentence(5) }
    street {Faker::Address.street_name }
    zip {Faker::Address.zip }
    apt {Faker::Address.secondary_address}
    rooms {(1..5).to_a.sample }
    post_type {['rent', 'sale'].sample }
    duration {['by day', 'by hour', 'by month'].sample }
    latitude { Faker::Address.latitude }
    longitude { Faker::Address.longitude }

    association :user
    city_id 19521
    state_id 32
  end
end


