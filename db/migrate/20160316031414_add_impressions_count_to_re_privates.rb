class AddImpressionsCountToRePrivates < ActiveRecord::Migration
  def change
    add_column :re_privates, :impressions_count, :integer, default: 0
  end
end
