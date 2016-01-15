class AddLinkAndDescriptionToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :link, :string
    add_column :posts, :description, :string
  end
end
