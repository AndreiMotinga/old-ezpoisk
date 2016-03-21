FactoryGirl.define do
  factory :partner do
    title { Faker::Lorem.sentence 2 }
    link "//google.com"
    active true
    budget 1000
    bid 5
    current_balance 0
    impressions_count 0
    position :top

    association :user
  end
end

               #  :debits => :integer,
               # :credits => :integer,
     #           :balance => :integer,
