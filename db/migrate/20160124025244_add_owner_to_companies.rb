class AddOwnerToCompanies < ActiveRecord::Migration
  def change
    add_column :companies, :owner, :string
  end
end
