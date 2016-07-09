class AddSubcategoryToJobs < ActiveRecord::Migration
  def change
    add_column :jobs, :subcategory, :string
  end
end
