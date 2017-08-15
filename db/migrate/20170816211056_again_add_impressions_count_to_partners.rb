class AgainAddImpressionsCountToPartners < ActiveRecord::Migration[5.1]
  def change
    add_column :partners, :impressions_count, :integer, null: false, default: 0
  end
end
