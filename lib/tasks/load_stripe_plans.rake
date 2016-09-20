desc "Loads stripe plans in stripe_plans table"
namespace :db do
  task load_plans: :environment do
    PLANS = [
      {
        stripe_id: :monthly_base,
        name: "EZPOISK Base Plan",
        select_name: "EZPOISK Base Plan ($99, priority 1)",
        amount: 9900,
        total: 9900,
        priority: 1,
        interval: "month"
      },
      {
        stripe_id: :monthly_standart,
        name: "EZPOISK Standart Plan",
        select_name: "EZPOISK Standart Plan ($249, priority 2)",
        amount: 249_00,
        total:  249_00,
        priority: 2,
        interval: "month"
      },
      {
        stripe_id: :monthly_premium,
        name: "EZPOISK Premium Plan",
        select_name: "EZPOISK Premium Plan ($599, priority 3)",
        amount: 599_00,
        total: 599_00,
        priority: 3,
        interval: "month"
      }
    ].freeze

    PLANS.each { |plan| StripePlan.create(plan) }
    puts "Loaded Stripe Plans"
  end
end
