class RenameColumnOnJobs < ActiveRecord::Migration[5.0]
  def change
    rename_column :jobs, :category, :post_type
    add_column :jobs, :category, :string, default: ""
  end
end
