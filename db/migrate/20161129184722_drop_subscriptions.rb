class DropSubscriptions < ActiveRecord::Migration[5.0]
  def change
    drop_table :subscriptions
  end
end
