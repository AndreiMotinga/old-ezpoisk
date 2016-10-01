class AddSlugToStates < ActiveRecord::Migration[5.0]
  def change
    add_column :states, :slug, :string, index: true
    add_column :cities, :slug, :string, index: true
  end
end
