class RenameStateToStatusAtStireSubscriptions < ActiveRecord::Migration
  def change
    rename_column :stripe_subscriptions, :state, :status
  end
end
