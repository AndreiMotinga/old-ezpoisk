class RemovePostTypeFromJobs < ActiveRecord::Migration
  def change
    remove_column :jobs, :post_type
  end
end
