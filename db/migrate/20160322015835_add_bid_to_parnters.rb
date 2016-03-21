class AddBidToParnters < ActiveRecord::Migration
  def change
    add_column :partners, :bid, :integer
  end
end
