class AddPriorityToService < ActiveRecord::Migration
  def change
    add_column :services, :priority, :integer, default: 0, null: false
  end
end
