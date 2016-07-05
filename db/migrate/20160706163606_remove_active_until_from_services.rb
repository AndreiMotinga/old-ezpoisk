class RemoveActiveUntilFromServices < ActiveRecord::Migration
  def change
    remove_column :services, :active_until
  end
end
