class AddCurrentBalanceToPartners < ActiveRecord::Migration
  def change
    add_column :partners, :current_balance, :integer, default: 0
  end
end
