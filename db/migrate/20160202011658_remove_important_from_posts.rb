class RemoveImportantFromPosts < ActiveRecord::Migration
  def change
    remove_column :posts, :important
  end
end
