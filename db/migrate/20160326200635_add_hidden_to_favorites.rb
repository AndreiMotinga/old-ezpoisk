class AddHiddenToFavorites < ActiveRecord::Migration
  def change
    add_column :favorites, :hidden, :boolean
  end
end
