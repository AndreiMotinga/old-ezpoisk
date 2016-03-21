class AddImpressionsCountToPartners < ActiveRecord::Migration
  def change
    add_column :partners, :impressions_count, :integer, default: 0
  end
end
