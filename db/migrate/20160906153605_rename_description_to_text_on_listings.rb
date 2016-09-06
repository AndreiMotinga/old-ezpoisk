class RenameDescriptionToTextOnListings < ActiveRecord::Migration[5.0]
  def change
    rename_column :re_privates, :description, :text
    rename_column :services, :description, :text
    rename_column :jobs, :description, :text
    rename_column :sales, :description, :text
  end
end
