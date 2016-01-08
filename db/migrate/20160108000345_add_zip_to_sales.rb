class AddZipToSales < ActiveRecord::Migration
  def change
    add_column :sales, :zip, :integer
  end
end
