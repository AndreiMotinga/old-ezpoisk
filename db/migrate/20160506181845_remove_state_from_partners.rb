class RemoveStateFromPartners < ActiveRecord::Migration
  def change
    remove_column :partners, :state_id
  end
end
