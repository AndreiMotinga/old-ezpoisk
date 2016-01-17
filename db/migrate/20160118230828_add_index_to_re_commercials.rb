class AddIndexToReCommercials < ActiveRecord::Migration
  def change
    add_index :re_commercials, :price
    add_index :re_commercials, :post_type
    add_index :re_commercials, :category
    add_index :re_commercials, :space
  end
end
