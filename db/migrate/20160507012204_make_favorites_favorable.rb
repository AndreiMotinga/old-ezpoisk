class MakeFavoritesFavorable < ActiveRecord::Migration
  def change
    rename_column :favorites, :post_id, :favorable_id
    rename_column :favorites, :post_type, :favorable_type
  end
end
