class DropGallery < ActiveRecord::Migration[5.0]
  def change
    drop_table :galleries
  end
end
