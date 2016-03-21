class AddDebitsCreditsBalanceToPartners < ActiveRecord::Migration
  def change
    add_column :partners, :debits, :integer
    add_column :partners, :credits, :integer
    add_column :partners, :balance, :integer
  end
end
