class AddShowOnHomePageToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :show_on_homepage, :boolean
  end
end
