class RenameBodyPosts < ActiveRecord::Migration
  def change
    rename_column :posts, :body, :text
  end
end
