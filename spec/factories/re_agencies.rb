FactoryGirl.define do
  factory :re_agency do
    title "Real Estate Example Group"
    street "2520 Batchelder str, Suite 7"
    phone "929-293-5385, 347-956-3444"
    email "andrei@example.com"
    site "www.example.com"
    description "If you’re like most people, your home is the most important investment you’ll ever make. The team of professionals at Maximillion Realty, Inc. offers many successful years of experience providing outstanding service to homebuyers, sellers, and investors in the complete range of economic climates. From condos, to single family homes, town houses, lofts, or apartment buildings, we’ve got the latest listings, and the friendliest, most knowledgeable team of brokers and agents in the New York real estate industry."

    association :user, factory: :user
    city_id 18058
    state_id 32
    active true
  end
end
