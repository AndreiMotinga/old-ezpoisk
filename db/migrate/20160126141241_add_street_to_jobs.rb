class AddStreetToJobs < ActiveRecord::Migration
  def change
    add_column :jobs, :street, :string
  end
end
