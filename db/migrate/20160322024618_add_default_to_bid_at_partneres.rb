class AddDefaultToBidAtPartneres < ActiveRecord::Migration
  def change
    change_column_default :partners, :bid, 0
  end
end
