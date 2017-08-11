class ChangePublished < ActiveRecord::Migration[5.1]
  def change
    remove_column :posts, :published
    add_column :posts, :published_at, :datetime, default: -> { 'CURRENT_TIMESTAMP' }
  end
end
