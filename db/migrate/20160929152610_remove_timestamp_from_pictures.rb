class RemoveTimestampFromPictures < ActiveRecord::Migration[5.0]
  def change
    remove_column :pictures, :created_at
    remove_column :pictures, :updated_at
  end
end
