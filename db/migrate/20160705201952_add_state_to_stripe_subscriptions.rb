class AddStateToStripeSubscriptions < ActiveRecord::Migration
  def change
    add_column :stripe_subscriptions, :state, :string
  end
end
