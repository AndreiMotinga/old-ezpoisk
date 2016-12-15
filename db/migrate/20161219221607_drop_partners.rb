class DropPartners < ActiveRecord::Migration[5.0]
  def change
    drop_table :partners
  end
end
