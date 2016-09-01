FactoryGirl.define do
  factory :partner do
    title { Faker::Lorem.sentence.truncate(45) }
    description { Faker::Lorem.sentence.truncate(45) }
    url "//google.com?image=#{(1..10).to_a.sample}"
    image { File.new("#{Rails.root}/spec/support/fixtures/#{(1..10).to_a.sample}.jpg") }
    position { [:left, :right].sample }

    association :user
  end
end
