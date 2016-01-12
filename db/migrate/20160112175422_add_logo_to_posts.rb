class AddLogoToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :logo, :string
  end
end
