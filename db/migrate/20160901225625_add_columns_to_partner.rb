class AddColumnsToPartner < ActiveRecord::Migration[5.0]
  def change
    add_column :partners, :description, :string, default: "", null: false
    rename_column :partners, :link, :url
  end
end
