class RemoveExtraFromPosts < ActiveRecord::Migration
  def change
    remove_column :posts, :category
    remove_column :posts, :subcategory
    remove_column :posts, :link
    remove_column :posts, :show_on_homepage
    remove_column :posts, :main
    remove_column :posts, :description
    remove_column :posts, :interesting
    remove_column :posts, :video_url
  end
end
