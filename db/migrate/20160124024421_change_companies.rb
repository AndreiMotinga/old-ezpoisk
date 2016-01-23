class ChangeCompanies < ActiveRecord::Migration
  def change
    remove_column :companies, :user_id
    add_column :companies, :user, :string
  end
end
