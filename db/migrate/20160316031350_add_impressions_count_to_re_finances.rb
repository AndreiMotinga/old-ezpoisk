class AddImpressionsCountToReFinances < ActiveRecord::Migration
  def change
    add_column :re_finances, :impressions_count, :integer, default: 0
  end
end
