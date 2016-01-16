class ApproveForumPosts < ActiveRecord::Migration
  def change
    change_column :forem_posts, :state, :string, :default => 'approved', :null => false
  end
end
