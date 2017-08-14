class AddPicturesCountToListings < ActiveRecord::Migration[5.1]
  def change
    add_column :listings, :pictures_count, :integer, null: false, default: 0
  end
end
