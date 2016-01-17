class AddIndexToJobs < ActiveRecord::Migration
  def change
    add_index :jobs, :post_type
    add_index :jobs, :category
  end
end
