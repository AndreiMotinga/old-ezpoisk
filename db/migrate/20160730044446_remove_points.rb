class RemovePoints < ActiveRecord::Migration[5.0]
  def change
    drop_table :points
  end
end
