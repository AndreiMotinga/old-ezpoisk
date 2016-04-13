class AddDefaultToDescAtSales < ActiveRecord::Migration
  def change
    change_column :sales, :description, :text, default: "", null: false
  end
end
