class RemoveActiveFromServicesAgain < ActiveRecord::Migration
  def change
    remove_column :services, :active
  end
end
