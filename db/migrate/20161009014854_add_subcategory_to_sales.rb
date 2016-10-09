class AddSubcategoryToSales < ActiveRecord::Migration[5.0]
  def change
    add_column :sales, :post_type, :string, default: "", null: false
    Sale.update_all(post_type: "selling")
  end
end
