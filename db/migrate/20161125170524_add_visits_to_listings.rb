class AddVisitsToListings < ActiveRecord::Migration[5.0]
  def change
    add_column :listings, :visits, :integer, default: 0
  end
end
