class AddQuadroIndexesToFavorites < ActiveRecord::Migration
  def change
    add_index :favorites, [:user_id, :post_id, :post_type, :favorite], unique: true, name: "quadro_index_on_favorite"
    add_index :favorites, [:user_id, :post_id, :post_type, :hidden], unique: true, name: "quadro_index_on_hidden"
  end
end
