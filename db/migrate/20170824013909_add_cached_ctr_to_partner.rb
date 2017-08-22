class AddCachedCtrToPartner < ActiveRecord::Migration[5.1]
  def change
    add_column :partners, :cached_ctr, :decimal
  end
end
