class DropStripeSubscriptions < ActiveRecord::Migration
  def change
    drop_table :stripe_subscriptions
  end
end
