class AddContactedByUsToCompanies < ActiveRecord::Migration
  def change
    add_column :companies, :contacted_by_serghei, :boolean
    add_column :companies, :contacted_by_andrei, :boolean
    add_column :companies, :contacted_by_greta, :boolean
  end
end
