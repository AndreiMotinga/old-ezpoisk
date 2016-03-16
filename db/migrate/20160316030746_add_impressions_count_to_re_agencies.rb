class AddImpressionsCountToReAgencies < ActiveRecord::Migration
  def change
    add_column :re_agencies, :impressions_count, :integer, default: 0
  end
end
