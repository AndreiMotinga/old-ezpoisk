class RemoveSubcateoriesFromJobs < ActiveRecord::Migration[5.0]
  def change
    remove_column :jobs, :subcategory
  end
end
