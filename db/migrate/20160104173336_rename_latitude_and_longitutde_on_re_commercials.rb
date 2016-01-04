class RenameLatitudeAndLongitutdeOnReCommercials < ActiveRecord::Migration
  def change
    rename_column :re_commercials, :latitude, :lat
    rename_column :re_commercials, :longitude, :lng
  end
end
