class AddCounterCacheToCommantables < ActiveRecord::Migration[5.1]
  def change
    add_column :posts, :comments_count, :integer, null: false, default: 0
    add_column :listings, :comments_count, :integer, null: false, default: 0
    add_column :questions, :comments_count, :integer, null: false, default: 0
    add_column :answers, :comments_count, :integer, null: false, default: 0
  end
end
