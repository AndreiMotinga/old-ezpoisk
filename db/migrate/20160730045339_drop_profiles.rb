class DropProfiles < ActiveRecord::Migration[5.0]
  def change
    drop_table :profiles
  end
end
