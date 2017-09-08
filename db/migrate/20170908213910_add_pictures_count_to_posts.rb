class AddPicturesCountToPosts < ActiveRecord::Migration[5.1]
  def change
    add_column :posts, :pictures_count, :integer, default: 0
  end
end
