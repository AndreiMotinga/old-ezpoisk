class AddCachedTagsToPosts < ActiveRecord::Migration[5.0]
  def change
    add_column :posts, :cached_tags, :string, default: ""
  end
end
