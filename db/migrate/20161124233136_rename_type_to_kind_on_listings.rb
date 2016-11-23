class RenameTypeToKindOnListings < ActiveRecord::Migration[5.0]
  def change
    rename_column :listings, :type, :kind
  end
end
