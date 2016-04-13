class AddDefaultToDescAtJobs < ActiveRecord::Migration
  def change
    change_column :jobs, :description, :text, default: "", null: false
  end
end
