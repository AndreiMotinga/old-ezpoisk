class AddHomeToPosts < ActiveRecord::Migration[5.0]
  def change
    add_column :posts, :home, :boolean
  end
end
