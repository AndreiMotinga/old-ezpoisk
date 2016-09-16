class AddRemoteToJobs < ActiveRecord::Migration[5.0]
  def change
    add_column :jobs, :remote, :boolean, default: false
  end
end
