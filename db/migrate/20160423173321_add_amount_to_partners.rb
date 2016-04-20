class AddAmountToPartners < ActiveRecord::Migration
  def change
    add_column :partners, :amount, :integer
  end
end
