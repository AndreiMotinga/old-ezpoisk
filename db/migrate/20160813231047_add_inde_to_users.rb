class AddIndeToUsers < ActiveRecord::Migration[5.0]
  def change
    add_index :users, :state_id
    add_index :users, :city_id
  end
end
