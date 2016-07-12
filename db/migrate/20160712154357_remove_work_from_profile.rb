class RemoveWorkFromProfile < ActiveRecord::Migration
  def change
    remove_column :profiles, :work
  end
end
