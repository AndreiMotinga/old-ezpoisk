class AddImageRemoteUrlToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :image_remote_url, :string
  end
end
