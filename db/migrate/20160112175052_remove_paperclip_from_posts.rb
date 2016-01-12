class RemovePaperclipFromPosts < ActiveRecord::Migration
  def change
    remove_column :posts, :logo_file_name
    remove_column :posts, :logo_content_type
    remove_column :posts, :logo_file_size
    remove_column :posts, :logo_updated_at
  end
end
