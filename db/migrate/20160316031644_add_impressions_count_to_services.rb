class AddImpressionsCountToServices < ActiveRecord::Migration
  def change
    add_column :services, :impressions_count, :integer, default: 0
  end
end
