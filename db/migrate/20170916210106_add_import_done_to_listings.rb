class AddImportDoneToListings < ActiveRecord::Migration[5.1]
  def change
    add_column :listings, :done, :boolean
  end
end
