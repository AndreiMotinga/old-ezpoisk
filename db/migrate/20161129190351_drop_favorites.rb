class DropFavorites < ActiveRecord::Migration[5.0]
  def change
    drop_table :favorites
  end
end
