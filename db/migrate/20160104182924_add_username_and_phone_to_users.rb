class AddUsernameAndPhoneToUsers < ActiveRecord::Migration
  def change
    add_column :users, :username, :string, null: false
    add_column :users, :phone, :string, null: false
  end
end
