class ChangePriceOnCommercials < ActiveRecord::Migration[5.0]
  def change
    change_column :re_commercials, :price, :integer, default: nil, null: true
  end
end
