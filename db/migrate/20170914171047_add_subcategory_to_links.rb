class AddSubcategoryToLinks < ActiveRecord::Migration[5.1]
  def change
    add_column :links, :subcategory, :string
  end
end
