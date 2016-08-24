class AddSourceToPosts < ActiveRecord::Migration[5.0]
  def change
    add_column :posts, :source, :string
  end
end
