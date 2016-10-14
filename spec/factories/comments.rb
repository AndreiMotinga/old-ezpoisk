FactoryGirl.define do
  factory :comment do
    text { Faker::Lorem.paragraph }

    association :commentable, factory: :re_private
    user
  end
end
