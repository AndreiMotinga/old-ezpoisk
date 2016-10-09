FactoryGirl.define do
  factory :question do
    title { Faker::Name.title }
    text { Faker::Lorem.paragraph(20) }
    tag_list ["auto"]
    cached_tags "auto"
  end
end
