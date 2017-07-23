class AddLegendToServices < ActiveRecord::Migration[5.1]
  def change
    add_column :listings, :legend, :string, null: false, default: ""
  end
end
