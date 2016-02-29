class AddInterestingToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :interesting, :boolean
  end
end
