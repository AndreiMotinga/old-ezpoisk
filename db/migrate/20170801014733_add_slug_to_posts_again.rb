class AddSlugToPostsAgain < ActiveRecord::Migration[5.1]
  def change
    add_column :posts, :slug, :string, null: false, default: "", uniq: true
  end
end
