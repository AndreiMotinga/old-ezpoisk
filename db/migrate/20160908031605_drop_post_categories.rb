class DropPostCategories < ActiveRecord::Migration[5.0]
  def change
    drop_table :post_categories
    drop_table :categories
  end
end
