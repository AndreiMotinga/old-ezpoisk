class AddPriceToSales < ActiveRecord::Migration
  def change
    add_column :sales, :price, :string
  end
end
