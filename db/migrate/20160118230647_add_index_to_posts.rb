class AddIndexToPosts < ActiveRecord::Migration
  def change
    add_index :posts, :category
  end
end
