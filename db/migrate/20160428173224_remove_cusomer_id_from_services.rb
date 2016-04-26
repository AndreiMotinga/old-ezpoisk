class RemoveCusomerIdFromServices < ActiveRecord::Migration
  def change
    remove_column :services, :customer_id
  end
end
