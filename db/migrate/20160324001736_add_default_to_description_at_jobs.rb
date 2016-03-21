class AddDefaultToDescriptionAtJobs < ActiveRecord::Migration
  def change
    change_column :jobs, :description, :string, default: ""
  end
end
