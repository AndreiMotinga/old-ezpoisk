class AddSourceToListings < ActiveRecord::Migration[5.1]
  def change
    add_column :listings, :source, :string
  end
end
