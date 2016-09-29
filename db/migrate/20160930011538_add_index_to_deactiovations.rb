class AddIndexToDeactiovations < ActiveRecord::Migration[5.0]
  def change
    add_index :deactivations, [:user_id, :deactivatable_id, :deactivatable_type], unique: true, name: "deactivatable_index"
  end
end
