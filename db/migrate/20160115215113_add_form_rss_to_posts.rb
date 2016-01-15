class AddFormRssToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :from_rss, :boolean
  end
end
