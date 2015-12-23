class RemovePictureIdFromRePrivates < ActiveRecord::Migration
  def change
    remove_column :re_privates, :picture_id
  end
end
