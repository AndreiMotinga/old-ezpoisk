class AddIndexToRePrivates < ActiveRecord::Migration
  def change
    add_index :re_privates, :price
    add_index :re_privates, :space
  end
end
