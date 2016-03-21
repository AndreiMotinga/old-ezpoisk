class AddBudgetToPartners < ActiveRecord::Migration
  def change
    add_column :partners, :budget, :integer, default: 0
  end
end
