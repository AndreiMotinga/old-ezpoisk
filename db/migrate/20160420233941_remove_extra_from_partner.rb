class RemoveExtraFromPartner < ActiveRecord::Migration
  def change
    remove_column :partners, :budget
    remove_column :partners, :debits
    remove_column :partners, :credits
    remove_column :partners, :balance
    remove_column :partners, :bid
    remove_column :partners, :current_balance
  end
end
