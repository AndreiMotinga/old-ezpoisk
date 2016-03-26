class AddFavoriteToFavorites < ActiveRecord::Migration
  def change
    add_column :favorites, :favorite, :boolean

    Favorite.find_each{|f| f.favorite = true; f.save }
  end
end
