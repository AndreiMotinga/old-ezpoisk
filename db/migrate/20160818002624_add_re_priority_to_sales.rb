class AddRePriorityToSales < ActiveRecord::Migration[5.0]
  def change
    add_column :sales, :priority, :integer, default: 0, null: false
  end
end
