class RemoveCachedCtrFromPartners < ActiveRecord::Migration[5.1]
  def change
    remove_column :partners, :cached_ctr
  end
end
