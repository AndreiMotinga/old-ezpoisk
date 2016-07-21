desc "Loads stripe plans in stripe_plans table"
namespace :db do
  task load_plans: :environment do
    PLANS = [
      {
        stripe_id: :monthly_base,
        name: "EZPOISK Monthly Base Plan",
        amount: 2994,
        total: 2994,
        priority: 1,
        interval: "month"
      },
      {
        stripe_id: :yearly_base,
        name: "EZPOISK Yearly Base Plan",
        amount: 299_28,
        total: 2994 * 12,
        priority: 2,
        interval: "year"
      },
      {
        stripe_id: :monthly_standart,
        name: "EZPOISK Monthly Standart Plan",
        amount: 5994,
        total:  5994,
        priority: 3,
        interval: "month"
      },
      {
        stripe_id: :yearly_standart,
        name: "EZPOISK Yearly Standart Plan",
        amount: 599_28,
        total:  5994 * 12,
        priority: 4,
        interval: "year"
      },
      {
        stripe_id: :monthly_premium,
        name: "EZPOISK Monthly Premium Plan",
        amount: 14_494,
        total: 14_494,
        priority: 5,
        interval: "month"
      },
      {
        stripe_id: :yearly_premium,
        name: "EZPOISK Yearly Premium Plan",
        amount: 1499_28,
        total: 14_494 * 12,
        priority: 6,
        interval: "year"
      }
    ]

    PLANS.each {|plan| StripePlan.create(plan)}
    puts "Loaded Stripe Plans"
  end
end
