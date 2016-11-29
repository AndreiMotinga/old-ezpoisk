class AddIndexToParentIdOnComments < ActiveRecord::Migration[5.0]
  def change
    add_index :comments, :parent_id
  end
end
