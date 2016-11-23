class DropStripeSubscriptions < ActiveRecord::Migration[5.0]
  def change
    drop_table :stripe_subscriptions
  end
end
