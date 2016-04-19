class AddLatLngZipToProfiles < ActiveRecord::Migration
  def change
    add_column :profiles, :lat, :float
    add_column :profiles, :lng, :float
    add_column :profiles, :zip, :integer
  end
end
