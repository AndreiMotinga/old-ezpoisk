class AddDefaultToDescAtPosts < ActiveRecord::Migration
  def change
    change_column :posts, :description, :text, default: "", null: false
    change_column :posts, :text, :text, default: "", null: false
  end
end
