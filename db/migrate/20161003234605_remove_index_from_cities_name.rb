class RemoveIndexFromCitiesName < ActiveRecord::Migration[5.0]
  def change
    remove_index :cities, :name
    remove_index :states, :abbr
  end
end
