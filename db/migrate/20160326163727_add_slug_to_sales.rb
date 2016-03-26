class AddSlugToSales < ActiveRecord::Migration
  def change
    add_column :sales, :slug, :string
    add_index :sales, :slug, unique: true
  end
end
