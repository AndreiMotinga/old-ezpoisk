class RenameDescriptionOnPartners < ActiveRecord::Migration[5.0]
  def change
    rename_column :partners, :description, :text
  end
end
