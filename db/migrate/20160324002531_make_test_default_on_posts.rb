class MakeTestDefaultOnPosts < ActiveRecord::Migration
  def change
    change_column :posts, :text, :text, default: ""
  end
end
