class AddMainToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :main, :boolean
  end
end
