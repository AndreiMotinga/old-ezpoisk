class RemoveNullConstraintFromPriceOnRePrivates < ActiveRecord::Migration[5.0]
  def change
    change_column :re_privates, :price, :integer, default: nil, null: true
  end
end
