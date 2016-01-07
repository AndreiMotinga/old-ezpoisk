class AddLatLngZipToJobs < ActiveRecord::Migration
  def change
    add_column :jobs, :lat, :float
    add_column :jobs, :lng, :float
    add_column :jobs, :zip, :integer
  end
end
