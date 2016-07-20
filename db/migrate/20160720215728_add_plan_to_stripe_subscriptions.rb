class AddPlanToStripeSubscriptions < ActiveRecord::Migration
  def change
    add_column :stripe_subscriptions, :plan, :string
  end
end
