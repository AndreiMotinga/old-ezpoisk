class DropCampaigns < ActiveRecord::Migration[5.1]
  def change
    drop_table :campaigns
  end
end
