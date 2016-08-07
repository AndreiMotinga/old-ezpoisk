class ChangePriceOnSales < ActiveRecord::Migration[5.0]
  def change
    rename_column :sales, :price, :old_price
    add_column :sales, :price, :integer, default: nil, null: true
    Sale.find_each{|p| p.update_column(:price, p.old_price.to_i)}
    remove_column :sales, :old_price
  end
end
