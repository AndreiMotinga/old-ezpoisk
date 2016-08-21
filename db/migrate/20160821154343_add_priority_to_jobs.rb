class AddPriorityToJobs < ActiveRecord::Migration[5.0]
  def change
    add_column :jobs, :priority, :integer, default: 0, null: false
  end
end
