class RemoveLogoFromPosts < ActiveRecord::Migration
  def change
    remove_column :posts, :logo
  end
end
