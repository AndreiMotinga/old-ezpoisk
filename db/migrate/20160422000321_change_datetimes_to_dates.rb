class ChangeDatetimesToDates < ActiveRecord::Migration
  def change
    remove_column :partners, :start_time
    remove_column :partners, :active_until

    add_column :partners, :start_date, :date
    add_column :partners, :active_until, :date
  end
end
