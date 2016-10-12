class RenameStreet < ActiveRecord::Migration[5.0]
  def change
    rename_column :re_privates, :street, :title
  end
end
