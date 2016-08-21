class RemoveTimestamplsFromPostCategories < ActiveRecord::Migration[5.0]
  def change
    remove_column :post_categories, :updated_at
    remove_column :post_categories, :created_at
  end
end
