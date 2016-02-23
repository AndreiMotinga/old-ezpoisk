class AddSuccessToCompanies < ActiveRecord::Migration
  def change
    add_column :companies, :success, :boolean
  end
end
