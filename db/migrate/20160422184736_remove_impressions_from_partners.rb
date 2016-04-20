class RemoveImpressionsFromPartners < ActiveRecord::Migration
  def change
    remove_column :partners, :impressions_count
  end
end
