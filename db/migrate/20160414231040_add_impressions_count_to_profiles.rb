class AddImpressionsCountToProfiles < ActiveRecord::Migration
  def change
    add_column :profiles, :impressions_count, :integer, default: 0, null: false
  end
end
