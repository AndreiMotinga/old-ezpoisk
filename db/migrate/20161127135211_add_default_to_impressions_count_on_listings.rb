class AddDefaultToImpressionsCountOnListings < ActiveRecord::Migration[5.0]
  def change
    change_column :listings, :impressions_count, :integer, default: 0
  end
end
