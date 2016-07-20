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

# Once you have your plans defined, you can run
#
#   rake stripe:prepare
#
# This will export any new plans to stripe.com so that you can
# begin using them in your API calls.

Stripe.plan :monthly_base do |plan|
  # plan name as it will appear on credit card statements
  plan.name = "EZPOISK Monthly Base Plan"

  # amount in cents. This is 6.99
  plan.amount = 3000

  # currency to use for the plan (default 'usd')
  plan.currency = "usd"

  # interval must be either 'week', 'month' or 'year'
  plan.interval = "month"

  # only bill once every three months (default 1)
  plan.interval_count = 1
end

Stripe.plan :monthly_premium do |plan|
  # plan name as it will appear on credit card statements
  plan.name = "EZPOISK Monthly Premium Plan"

  # amount in cents. This is 6.99
  plan.amount = 6000

  # currency to use for the plan (default 'usd')
  plan.currency = "usd"

  # interval must be either 'week', 'month' or 'year'
  plan.interval = "month"

  # only bill once every three months (default 1)
  plan.interval_count = 1
end
