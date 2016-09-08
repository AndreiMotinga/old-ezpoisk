class ChangeBudgetToBeInteger < ActiveRecord::Migration[5.0]
  def change
    remove_column :partners, :budget
    add_column :partners, :budget, :integer
  end
end
