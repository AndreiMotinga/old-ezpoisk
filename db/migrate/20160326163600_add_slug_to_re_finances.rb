class AddSlugToReFinances < ActiveRecord::Migration
  def change
    add_column :re_finances, :slug, :string
    add_index :re_finances, :slug, unique: true
  end
end
