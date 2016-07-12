FactoryGirl.define do
  factory :profile do
    phone "1234567890"
    site "ezpoisk.com"
    about "info about"
    street "1970 East 18th str"
    facebook "facebook_link"
    google "google_link"
    vk "vk link"
    ok "ok link"
    twitter "twitter link"

    state_id 32
    city_id 18031
  end
end
