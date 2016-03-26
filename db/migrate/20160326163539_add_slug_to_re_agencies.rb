class AddSlugToReAgencies < ActiveRecord::Migration
  def change
    add_column :re_agencies, :slug, :string
    add_index :re_agencies, :slug, unique: true
  end
end
