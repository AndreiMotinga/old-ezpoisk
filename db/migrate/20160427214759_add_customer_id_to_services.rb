class AddCustomerIdToServices < ActiveRecord::Migration
  def change
    add_column :services, :customer_id, :string
  end
end
