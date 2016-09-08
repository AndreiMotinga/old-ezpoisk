class AddApprovedToPartners < ActiveRecord::Migration[5.0]
  def change
    add_column :partners, :approved, :boolean, default: false
  end
end
