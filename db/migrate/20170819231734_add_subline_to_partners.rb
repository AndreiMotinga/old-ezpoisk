class AddSublineToPartners < ActiveRecord::Migration[5.1]
  def change
    add_column :partners, :subline, :string, null: false, default: ""
  end
end
