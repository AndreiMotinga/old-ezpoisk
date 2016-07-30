class AddIndexToPoints < ActiveRecord::Migration[5.0]
  def change
    add_index(:points, [:user_id, :author_id], unique: true)
  end
end
