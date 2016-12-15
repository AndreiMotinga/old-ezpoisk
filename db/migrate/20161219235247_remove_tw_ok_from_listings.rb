class RemoveTwOkFromListings < ActiveRecord::Migration[5.0]
  def change
    remove_column :listings, :tw
    remove_column :listings, :ok
  end
end
