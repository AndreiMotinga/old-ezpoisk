class ChangeDefaultPriceOnRePrivates < ActiveRecord::Migration[5.0]
  def change
    change_column_default :re_privates, :price, 0
  end
end
