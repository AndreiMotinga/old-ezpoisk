class RemoveNameFromPictures < ActiveRecord::Migration
  def change
    remove_column :pictures, :name
  end
end
