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
  plan.name = "EZPOISK Monthly Base Plan"
  plan.amount = 2994
  plan.currency = "usd"
  plan.interval = "month"
  plan.interval_count = 1
end

Stripe.plan :yearly_base do |plan|
  plan.name = "EZPOISK Yearly Base Plan"
  plan.amount = 299_28
  plan.currency = "usd"
  plan.interval = "year"
  plan.interval_count = 1
end

Stripe.plan :monthly_standart do |plan|
  plan.name = "EZPOISK Monthly Standart Plan"
  plan.amount = 5994
  plan.currency = "usd"
  plan.interval = "month"
  plan.interval_count = 1
end

Stripe.plan :yearly_standart do |plan|
  plan.name = "EZPOISK Yearly Standart Plan"
  plan.amount = 599_28
  plan.currency = "usd"
  plan.interval = "year"
  plan.interval_count = 1
end

Stripe.plan :monthly_premium do |plan|
  plan.name = "EZPOISK Monthly Premium Plan"
  plan.amount = 14_494
  plan.currency = "usd"
  plan.interval = "month"
  plan.interval_count = 1
end

Stripe.plan :yearly_premium do |plan|
  plan.name = "EZPOISK Yearly Premium Plan"
  plan.amount = 1499_28
  plan.currency = "usd"
  plan.interval = "year"
  plan.interval_count = 1
end
