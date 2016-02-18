class ChangeImageRemoteUrl < ActiveRecord::Migration
  def change
    change_column :posts, :image_remote_url, :text
  end
end
