class AddUniqIndexToPoints < ActiveRecord::Migration
  def change
    add_index(:points, [:user_id, :profile_id], unique: true)
  end
end
