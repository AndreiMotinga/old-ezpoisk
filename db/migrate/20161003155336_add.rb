class Add < ActiveRecord::Migration[5.0]
  def change
    add_index :states, :slug
    add_index :cities, :slug
  end
end
