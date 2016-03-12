class AddIndexesToFavorites < ActiveRecord::Migration
  def change
    add_index :favorites, [:user_id, :post_id, :post_type], unique: true
  end
end
