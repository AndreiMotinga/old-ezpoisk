class CleanupPartners < ActiveRecord::Migration[5.0]
  def change
    remove_column :partners, :page
    remove_column :partners, :position
    remove_column :partners, :start_date
    remove_column :partners, :active_until
    remove_column :partners, :amount
  end
end
