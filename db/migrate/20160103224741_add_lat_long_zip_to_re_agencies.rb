class AddLatLongZipToReAgencies < ActiveRecord::Migration
  def change
    add_column :re_agencies, :latitude, :float
    add_column :re_agencies, :longitude, :float
    add_column :re_agencies, :zip, :integer
  end
end
