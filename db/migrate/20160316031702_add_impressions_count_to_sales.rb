class AddImpressionsCountToSales < ActiveRecord::Migration
  def change
    add_column :sales, :impressions_count, :integer, default: 0
  end
end
