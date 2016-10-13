class AddConstraintToJobs < ActiveRecord::Migration[5.0]
  def change
    Job.update_all(category: "other")
    change_column :jobs, :category, :string, null: false
  end
end
