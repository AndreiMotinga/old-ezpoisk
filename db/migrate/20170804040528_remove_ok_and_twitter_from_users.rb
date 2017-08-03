class RemoveOkAndTwitterFromUsers < ActiveRecord::Migration[5.1]
  def change
    remove_column :users, :ok, :string
    remove_column :users, :twitter, :string
  end
end
