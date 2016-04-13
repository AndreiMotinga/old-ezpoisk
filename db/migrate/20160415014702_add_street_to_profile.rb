class AddStreetToProfile < ActiveRecord::Migration
  def change
    add_column :profiles, :street, :string, default: "", null: false
  end
end
