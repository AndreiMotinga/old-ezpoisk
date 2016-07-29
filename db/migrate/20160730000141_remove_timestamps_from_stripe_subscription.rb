class RemoveTimestampsFromStripeSubscription < ActiveRecord::Migration[5.0]
  def change
    remove_column :stripe_subscriptions, :created_at
    remove_column :stripe_subscriptions, :updated_at
  end
end
