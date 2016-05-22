class MakeFavorableIdIntegerOnFavorites < ActiveRecord::Migration
  def change
    change_column(
      :favorites,
      :favorable_id,
      "integer USING CAST(favorable_id AS integer)"
    )
  end
end
