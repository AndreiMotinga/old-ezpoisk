class AddActiveUntToPartners < ActiveRecord::Migration
  def change
    add_column :partners, :active_until, :date, default: Date.yesterday
  end
end
