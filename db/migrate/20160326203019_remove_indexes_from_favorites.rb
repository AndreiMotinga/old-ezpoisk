class RemoveIndexesFromFavorites < ActiveRecord::Migration
  def change
    remove_index :favorites, [:user_id, :post_id, :post_type]
  end
end
