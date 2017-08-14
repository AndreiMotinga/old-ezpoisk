class ForceEmailOnUsers < ActiveRecord::Migration[5.1]
  def change
    change_column :users, :email, :string, null: false, uniq: true
  end
end
