class RemoveExtraDataFromUsers < ActiveRecord::Migration
  def change
    remove_column :users, :name
    remove_column :users, :phone
    remove_column :users, :state_id
    remove_column :users, :city_id
    remove_column :users, :site
    remove_column :users, :lat
    remove_column :users, :lng

    remove_column :users, :avatar_file_name
    remove_column :users, :avatar_content_type
    remove_column :users, :avatar_file_size
    remove_column :users, :avatar_updated_at
  end
end
