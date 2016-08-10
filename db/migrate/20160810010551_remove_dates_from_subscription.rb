class RemoveDatesFromSubscription < ActiveRecord::Migration[5.0]
  def change
    remove_column :subscriptions, :created_at
    remove_column :subscriptions, :updated_at
  end
end
