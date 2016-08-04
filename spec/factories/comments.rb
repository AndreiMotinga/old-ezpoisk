FactoryGirl.define do
  factory :comment do
    title { Faker::Lorem.sentence }
    body { Faker::Lorem.paragraph }
    subject { Faker::Lorem.sentence }

    association :commentable, factory: :re_private
    user
  end
end
