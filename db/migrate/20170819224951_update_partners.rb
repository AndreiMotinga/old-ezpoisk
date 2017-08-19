class UpdatePartners < ActiveRecord::Migration[5.1]
  def change
    remove_column :partners, :campaign_id
    add_column :partners, :first, :string, null: false, default: ""
    add_reference :partners, :state, index: true
    add_reference :partners, :city, index: true
  end
end
