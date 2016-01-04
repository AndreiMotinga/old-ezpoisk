class RenameLatitudeAndLongitutdeOnReAgencies < ActiveRecord::Migration
  def change
    rename_column :re_agencies, :latitude, :lat
    rename_column :re_agencies, :longitude, :lng
  end
end
