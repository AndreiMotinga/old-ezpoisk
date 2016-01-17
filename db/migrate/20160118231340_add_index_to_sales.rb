class AddIndexToSales < ActiveRecord::Migration
  def change
    add_index :sales, :title
    add_index :sales, :description
  end
end
