class RemoveActiveUntil < ActiveRecord::Migration
  def change
    remove_column :partners, :end_date
    remove_column :partners, :active_until
  end
end
