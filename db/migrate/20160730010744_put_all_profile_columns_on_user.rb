class PutAllProfileColumnsOnUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :phone, :string, default: ""
    add_column :users, :state_id, :integer
    add_column :users, :city_id, :integer
    add_column :users, :site, :string
    add_column :users, :cover_file_name, :string
    add_column :users, :cover_content_type, :string
    add_column :users, :cover_file_size, :integer
    add_column :users, :cover_updated_at, :datetime
    add_column :users, :impressions_count, :integer
    add_column :users, :about, :text
    add_column :users, :street, :string
    add_column :users, :facebook, :string
    add_column :users, :google, :string
    add_column :users, :vk, :string
    add_column :users, :ok, :string
    add_column :users, :twitter, :string
    add_column :users, :lat, :float
    add_column :users, :lng, :float
    add_column :users, :zip, :integer

    User.find_each do |u|
      u.phone = u.profile.phone
      u.state_id = u.profile.state_id
      u.city_id = u.profile.city_id
      u.site = u.profile.site
      u.cover_file_name = u.profile.cover_file_name
      u.cover_content_type = u.profile.cover_content_type
      u.cover_file_size = u.profile.cover_file_size
      u.cover_updated_at = u.profile.cover_updated_at
      u.impressions_count = u.profile.impressions_count
      u.about = u.profile.about
      u.street = u.profile.street
      u.facebook = u.profile.facebook
      u.google = u.profile.google
      u.vk = u.profile.vk
      u.ok = u.profile.ok
      u.twitter = u.profile.twitter
      u.lat = u.profile.lat
      u.lng = u.profile.lng
      u.zip = u.profile.zip
      u.save
    end
  end
end
