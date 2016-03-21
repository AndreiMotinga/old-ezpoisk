class AddPositionToPartners < ActiveRecord::Migration
  def change
    add_column :partners, :position, :string, default: ''
  end
end
