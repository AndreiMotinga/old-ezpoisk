# frozen_string_literal: true

FactoryGirl.define do
  factory :karma do
    kind "created"
    amount 20

    user
  end
  factory :partner do
    final_url "https://www.ezpoisk.com"
    title { RU_KINDS.keys.sample + " в " + City.order("random ()").name }
    headline "Headline one of two"
    text { Faker::Lorem.sentence(2) }
    active true
    first "some string"
    subline "other string"
    user
  end

  factory :impression do
    impressionable nil
    kind "MyString"
    user nil
    ip_address "MyString"
    referrer "MyString"
  end

  factory :experience do
    kind %w[education job].sample
    name { Faker::Name.title }
    title { Faker::Name.title }
    country { Faker::Address.country }
    city { Faker::Address.city }
    start_year { (1960..Time.now.year).to_a.sample }
    end_year { (1960..Time.now.year).to_a.sample }

    trait :education do
      kind "education"
    end

    trait :job do
      kind "job"
    end
  end

  factory :post do
    title { Faker::Lorem.sentence(3) }
    text { Faker::Lorem.paragraph(5) }
    tag_list ["работа"]
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

    duration { RU_KINDS["недвижимость"][:duration].sample }
    rooms { RU_KINDS["недвижимость"][:rooms].sample }
    baths { (1..5).to_a.sample }

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
    site "https://www.example.com"

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

    trait :without_callbacks do
      after(:build) do |order|
        order.class.skip_callback :create, :after, :notify_slack
      end

      after(:create) do |order|
        order.class.set_callback :create, :after, :notify_slack
      end
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
    provider { %w[facebook vkontakte google].sample }
    uid { (rand * 100000).round }

    gender { %w[Мужчина Женщина].sample }
    name { Faker::Name.name }
    short_bio { Faker::Lorem.paragraph(1) }
    about { Faker::Lorem.paragraph(2) }
  end

  factory :contact do
    site { Faker::Internet.url }
    phone { Faker::PhoneNumber.cell_phone }
    fb { Faker::Internet.url("facebook.com") }
    vk { Faker::Internet.url("vk.com") }
    google { Faker::Internet.url("plus.google.com") }
    skype { Faker::Internet.user_name }
    street { Faker::Address.street_address }
    state_id 32
    city_id 18031
  end

  factory :question do
    title { Faker::Lorem.sentence + "?" }
    text { Faker::Lorem.paragraph(3) }
    tag_list ["auto"]
    user
  end
end
