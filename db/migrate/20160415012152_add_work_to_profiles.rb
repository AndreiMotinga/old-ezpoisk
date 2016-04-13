class AddWorkToProfiles < ActiveRecord::Migration
  def change
    add_column :profiles, :work, :text, default: "", null: false
  end
end
