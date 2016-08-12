class AddSourceToSales < ActiveRecord::Migration[5.0]
  def change
    add_column :sales, :source, :string
  end
end
