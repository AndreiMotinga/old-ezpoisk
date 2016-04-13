class RemoveExtraDataFromUsers < ActiveRecord::Migration
  def change
    User.find_each do |u|
      name = u.name || ""
      phone = u.phone || ""
      site = u.site || ""
      Profile.create(
        user: u,
        name: name,
        phone: phone,
        state_id: u.state_id,
        city_id: u.city_id,
        site: site
      )
    end

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
