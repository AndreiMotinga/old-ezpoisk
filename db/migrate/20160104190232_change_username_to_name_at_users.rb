class ChangeUsernameToNameAtUsers < ActiveRecord::Migration
  def change
    rename_column :users, :username, :name
  end
end
