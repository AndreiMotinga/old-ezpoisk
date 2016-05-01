# This file contains descriptions of all your stripe plans

# Example
# Stripe::Plans::PRIMO #=> 'primo'

# Stripe.plan :primo do |plan|
#
#   # plan name as it will appear on credit card statements
#   plan.name = 'Acme as a service PRIMO'
#
#   # amount in cents. This is 6.99
#   plan.amount = 699
#
#   # currency to use for the plan (default 'usd')
#   plan.currency = 'usd'
#
#   # interval must be either 'week', 'month' or 'year'
#   plan.interval = 'month'
#
#   # only bill once every three months (default 1)
#   plan.interval_count = 3
#
#   # number of days before charging customer's card (default 0)
#   plan.trial_period_days = 30
# end

Stripe.plan :basic_weekly do |plan|
  plan.name = "Basic Weekly Plan"
  plan.amount = 16_00
  plan.currency = "usd"
  plan.interval = "month"
end

Stripe.plan :basic_monthly do |plan|
  plan.name = "Basic Monthly Plan"
  plan.amount = 50_00
  plan.currency = "usd"
  plan.interval = "month"
end

Stripe.plan :basic_yearly do |plan|
  plan.name = "Basic Yearly Plan"
  plan.amount = 520_00
  plan.currency = "usd"
  plan.interval = "year"
end

# Stripe.plan :business_monthly do |plan|
#   plan.name = "Business Monthly Plan"
#   plan.amount = 100_00
#   plan.currency = "usd"
#   plan.interval = "month"
# end
#
# Stripe.plan :business_yearly do |plan|
#   plan.name = "Business Yearly Plan"
#   plan.amount = 960_00 # 80 a month
#   plan.currency = "usd"
#   plan.interval = "year"
# end
#
# Stripe.plan :golden_monthly do |plan|
#   plan.name = "Golden Monthly Plan"
#   plan.amount = 150_00
#   plan.currency = "usd"
#   plan.interval = "month"
# end
#
# Stripe.plan :golden_yearly do |plan|
#   plan.name = "Golden Yearly Plan"
#   plan.amount = 1560_00 # 130 a month
#   plan.currency = "usd"
#   plan.interval = "year"
# end

# Once you have your plans defined, you can run
#
#   rake stripe:prepare
#
# This will export any new plans to stripe.com so that you can
# begin using them in your API calls.
