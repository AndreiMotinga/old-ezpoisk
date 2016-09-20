desc "Loads stripe plans in stripe_plans table"
namespace :db do
  task load_plans: :environment do
    STRIPE_PLANS.each do |plan|
      StripePlan.create(
        name: plan[:name],
        stripe_id: plan[:stripe_id],
        interval: plan[:interval],
        amount: plan[:amount],
        total: plan[:total],
        priority: plan[:priority],
        select_name: plan[:select_name]
      )
    end
    puts "Loaded Stripe Plans"
  end
end
