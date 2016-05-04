FactoryGirl.define do
  factory :profile do
    name { Faker::Name.name }
    phone "1234567890"
    site "ezpoisk.com"
    about "info about"
    work "info work"
    street "1970 East 18th str"
    facebook "facebook_link"
    google "google_link"
    vk "vk link"
    ok "ok link"
    twitter "twitter link"
    motto "It will work out"

    association :state
    association :city
  end
end