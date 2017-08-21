class Change < ActiveRecord::Migration[5.1]
  def change
    rename_column :partners, :description, :text
  end
end
