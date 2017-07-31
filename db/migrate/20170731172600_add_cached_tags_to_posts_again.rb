class AddCachedTagsToPostsAgain < ActiveRecord::Migration[5.1]
  def change
    add_column :posts, :cached_tags, :string, default: "", null: false
  end
end
