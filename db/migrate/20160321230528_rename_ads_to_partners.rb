class RenameAdsToPartners < ActiveRecord::Migration
  def change
    rename_table :ads, :partners
  end
end
