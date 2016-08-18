class AddTokenToSales < ActiveRecord::Migration[5.0]
  def change
    add_column :sales, :token, :string
  end
end
