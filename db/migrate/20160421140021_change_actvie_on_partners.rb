class ChangeActvieOnPartners < ActiveRecord::Migration
  def change
    rename_column :partners, :active, :active_until
  end
end
