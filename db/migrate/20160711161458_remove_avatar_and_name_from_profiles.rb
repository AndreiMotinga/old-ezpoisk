class RemoveAvatarAndNameFromProfiles < ActiveRecord::Migration
  def change
    remove_column :profiles, :name, :string
    remove_column :profiles, :avatar_file_name, :string
    remove_column :profiles, :avatar_content_type, :string
    remove_column :profiles, :avatar_file_size, :string
    remove_column :profiles, :avatar_updated_at, :string
  end
end
