class AddTokenToJobs < ActiveRecord::Migration[5.0]
  def change
    add_column :jobs, :token, :string
  end
end
