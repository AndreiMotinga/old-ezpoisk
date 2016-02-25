class AllowNullOnUsersPhones < ActiveRecord::Migration
  def change
    change_column :users, :phone, :string, :null => true
  end
end
