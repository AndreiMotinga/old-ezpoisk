class AddLogoUrlToPosts < ActiveRecord::Migration[5.1]
  def change
    add_column :posts, :logo_url, :string
  end
end
