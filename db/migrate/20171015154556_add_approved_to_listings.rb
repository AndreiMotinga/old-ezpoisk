class AddApprovedToListings < ActiveRecord::Migration[5.1]
  def change
    add_column :listings, :approved, :boolean, default: false
  end
end
