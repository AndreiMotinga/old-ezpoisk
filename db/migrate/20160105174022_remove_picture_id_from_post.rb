class RemovePictureIdFromPost < ActiveRecord::Migration
  def change
    remove_column :posts, :picture_id
  end
end
