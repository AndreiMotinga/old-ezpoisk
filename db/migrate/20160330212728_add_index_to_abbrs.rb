class AddIndexToAbbrs < ActiveRecord::Migration
  def change
    add_index :states, :abbr, unique: true
  end
end
