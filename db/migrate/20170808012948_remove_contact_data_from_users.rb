class RemoveContactDataFromUsers < ActiveRecord::Migration[5.1]
  def change
    remove_column :users, :phone
    remove_column :users, :street
    remove_column :users, :state_id
    remove_column :users, :city_id
    remove_column :users, :vk
    remove_column :users, :facebook
    remove_column :users, :google
    remove_column :users, :skype
    remove_column :users, :site
  end
end
