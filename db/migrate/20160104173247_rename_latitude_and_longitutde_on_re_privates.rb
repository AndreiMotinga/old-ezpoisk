class RenameLatitudeAndLongitutdeOnRePrivates < ActiveRecord::Migration
  def change
    rename_column :re_privates, :latitude, :lat
    rename_column :re_privates, :longitude, :lng
  end
end
