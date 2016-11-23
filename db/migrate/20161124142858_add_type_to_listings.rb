class AddTypeToListings < ActiveRecord::Migration[5.0]
  def change
    add_column :listings, :type, :string
  end
end
