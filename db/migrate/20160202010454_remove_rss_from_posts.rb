class RemoveRssFromPosts < ActiveRecord::Migration
  def change
    remove_column :posts, :from_rss
  end
end
