class AddFromNameToListings < ActiveRecord::Migration[5.1]
  def change
    add_column :listings, :from_name, :string
  end
end
