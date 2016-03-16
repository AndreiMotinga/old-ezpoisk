class AddImpressionsCountToReCommercials < ActiveRecord::Migration
  def change
    add_column :re_commercials, :impressions_count, :integer, default: 0
  end
end
