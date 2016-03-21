FactoryGirl.define do
  factory :page do
    title "Домашняя"

    trait :ezrealty do
      title "Недвижимость"
    end
  end
end

               #  :debits => :integer,
               # :credits => :integer,
     #           :balance => :integer,
