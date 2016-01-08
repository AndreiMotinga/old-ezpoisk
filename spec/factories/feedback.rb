FactoryGirl.define do
  factory :feedback do
    body "Some text here"
    name "Andrei Some"
    email "some@gmailj.com"

    association :user
  end
end
