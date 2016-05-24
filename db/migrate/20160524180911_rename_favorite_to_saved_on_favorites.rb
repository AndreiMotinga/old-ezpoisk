class RenameFavoriteToSavedOnFavorites < ActiveRecord::Migration
  def change
    rename_column :favorites, :favorite, :saved
  end
end
