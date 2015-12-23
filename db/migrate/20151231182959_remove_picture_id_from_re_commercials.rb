class RemovePictureIdFromReCommercials < ActiveRecord::Migration
  def change
    remove_column :re_commercials, :picture_id
  end
end
