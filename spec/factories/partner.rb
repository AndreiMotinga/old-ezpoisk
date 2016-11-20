FactoryGirl.define do
  factory :partner do
    image {
      Rack::Test::UploadedFile.new(
        "#{Rails.root}/spec/support/fixtures/#{(1..10).to_a.sample}.jpg",
        "image/png"
      )
    }
    title { Faker::Lorem.sentence.truncate(45) }
    text { Faker::Lorem.sentence.truncate(45) }
    url "//google.com?image=#{(1..10).to_a.sample}"
    position { %w(left right).sample }
    budget { Faker::Number.number(2).to_i }
    phone "1234567890"
    email { Faker::Internet.email }

    association :user
  end
end
