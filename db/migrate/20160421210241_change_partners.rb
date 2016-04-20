class ChangePartners < ActiveRecord::Migration
  def change
    remove_column :partners, :start_date
    add_column :partners, :start_time, :datetime

    change_column :partners, :active_until, :datetime
  end
end
