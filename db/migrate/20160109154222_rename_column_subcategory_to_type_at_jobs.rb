class RenameColumnSubcategoryToTypeAtJobs < ActiveRecord::Migration
  def change
    rename_column :jobs, :subcategory, :post_type
  end
end
