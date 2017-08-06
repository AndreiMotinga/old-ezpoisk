# frozen_string_literal: true
FactoryGirl.define do
  factory :experience do
    kind ""
    name "MyString"
    title "MyString"
    country "MyString"
    city "MyString"
    start_year 1
    end_year 1
    user nil
  end
  factory :post do
    title { Faker::Lorem.sentence(3) }
    text { Faker::Lorem.paragraph(5) }
  end
  factory :action do
    actionable nil
  end
  factory :listing do
    kind { RU_KINDS.keys.sample }
    category { RU_KINDS[kind][:categories].sample }
    subcategory do
      if kind == "услуги"
        RU_KINDS[kind][:subcategories][category].sample
      else
        RU_KINDS[kind][:subcategories].sample
      end
    end

    title { Faker::Name.title }
    text { Faker::Lorem.paragraph(1) }
    active true
    price 40

    priority 1
    featured false
    token "MyString"

    state_id 32
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
      kind "работа"
      category { RU_KINDS["работа"][:categories].sample }
      subcategory { RU_KINDS["работа"][:subcategories].sample }
    end

    trait :apartment do
      kind "недвижимость"
      category "сдаю-в-аренду"
      subcategory "квартира"

      duration { RU_KINDS["недвижимость"][:duration].sample }
      rooms { RU_KINDS["недвижимость"][:rooms].sample }
      baths 1
      space 1000
      fee { [true, false].sample }
    end

    trait :service do
      kind "услуги"
      category { RU_KINDS["услуги"][:categories].sample }
      subcategory { RU_KINDS["услуги"][:subcategories][category].sample }
    end

    trait :sale do
      kind "продажи"
      category { RU_KINDS["продажи"][:categories].sample }
      subcategory { RU_KINDS["продажи"][:subcategories].sample }
    end

    trait :in_brooklyn do
      state_id 32
      city_id 18031
    end

    trait :in_bronx do
      state_id 32
      city_id 17882
    end

    trait :in_miami do
      state_id 9
      city_id 3964
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
