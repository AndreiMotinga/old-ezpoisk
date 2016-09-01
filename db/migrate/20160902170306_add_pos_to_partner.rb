class AddPosToPartner < ActiveRecord::Migration[5.0]
  def change
    add_column :partners, :position, :string
  end
end
