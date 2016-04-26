FactoryGirl.define do
  factory :partner do
    title { Faker::Lorem.sentence 2 }
    link "//google.com"

    position "Вверху"
    page "Недвижимость"
    image { File.new("#{Rails.root}/spec/support/fixtures/top.jpg") }

    association :user
    association :state

    trait :side do
      position "Справа"
      image { File.new("#{Rails.root}/spec/support/fixtures/side.jpg") }
    end

    trait :bottom do
      position "Внизу"
      image { File.new("#{Rails.root}/spec/support/fixtures/bottom.jpg") }
    end

    trait :current do
      start_date Date.today
      active_until 1.week.from_now
    end

    trait :past do
      start_date 1.month.ago
      active_until 3.weeks.ago
    end

    trait :future do
      start_date 1.week.from_now
      active_until 2.weeks.from_now
    end

    trait :bottom do
      position "Внизу"
    end

    trait :sales do
      page "Продается"
    end
  end
end
