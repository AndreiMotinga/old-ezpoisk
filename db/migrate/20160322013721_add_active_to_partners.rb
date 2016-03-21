class AddActiveToPartners < ActiveRecord::Migration
  def change
    add_column :partners, :active, :boolean
  end
end
