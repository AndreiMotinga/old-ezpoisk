class AddDefaultToFavorites < ActiveRecord::Migration
  def change
    change_column :favorites, :favorite, :boolean, null: false, default: false
    change_column :favorites, :hidden, :boolean, null: false, default: false
  end
end
