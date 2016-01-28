class AddDefaultValueToUsers < ActiveRecord::Migration
  def change
    change_column :users, :role, :string, :default => ''
    remove_column :users, :author
  end
end
