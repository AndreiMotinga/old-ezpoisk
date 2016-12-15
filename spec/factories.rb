# frozen_string_literal: true
FactoryGirl.define do
  factory :listing do
    kind { %w(real-estate jobs sales).sample }
    category { KINDS[kind][:categories].sample }
    subcategory { KINDS[kind][:subcategories].sample }

    title { Faker::Name.title }
    text { Faker::Lorem.paragraph(5) }
    active true
    price 40

    priority 1
    featured false
    token "MyString"

    state_id 33
    city_id 18_031
    street "MyString"
    lat 1.5
    lng 1.5
    zip 1

    phone "1234567890"
    email { Faker::Internet.email }
    vk "https://vk.com/id129328692"
    fb "https://www.facebook.com/101"
    gl "MyString"
    site "MyString"

    user

    trait :job do
      kind "jobs"
      category { KINDS[:jobs][:categories].sample }
      subcategory { KINDS[:jobs][:subcategories].sample }
    end

    trait :apartment do
      kind "real-estate"
      category "renting"
      subcategory "apartment"

      duration { KINDS["real-estate"][:duration].sample }
      rooms { KINDS["real-estate"][:rooms].sample }
      baths 1
      space 1000
      fee { [true, false].sample }
    end

    trait :service do
      kind "services"
      category { KINDS[:services][:categories].sample }
      subcategory { KINDS[:services][:subcategories][category].sample }
    end

    trait :sale do
      kind "sales"
      category { KINDS[:sales][:categories].sample }
      subcategory { KINDS[:sales][:subcategories].sample }
    end
  end
  factory :answer do
    title { Faker::Lorem.paragraph }
    text { Faker::Lorem.paragraph(20) }

    question
    user
  end

  factory :comment do
    text { Faker::Lorem.paragraph }
    association :commentable, factory: :listing
    user
  end

  factory :user do
    email { Faker::Internet.email }
    name { Faker::Name.name }
  end

  factory :question do
    title { Faker::Name.title }
    text { Faker::Lorem.paragraph(20) }
    tag_list ["auto"]
  end
end
