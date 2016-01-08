class AddLatLngZipToServices < ActiveRecord::Migration
  def change
    add_column :services, :lat, :float
    add_column :services, :lng, :float
    add_column :services, :zip, :integer
  end
end
