class RemoveLegendFromListings < ActiveRecord::Migration[5.1]
  def change
    remove_column :listings, :legend
  end
end
