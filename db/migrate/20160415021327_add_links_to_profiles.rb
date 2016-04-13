class AddLinksToProfiles < ActiveRecord::Migration
  def change
    add_column :profiles, :facebook, :string, default: "", null: false
    add_column :profiles, :google, :string, default: "", null: false
    add_column :profiles, :vk, :string, default: "", null: false
    add_column :profiles, :ok, :string, default: "", null: false
    add_column :profiles, :twitter, :string, default: "", null: false
  end
end
