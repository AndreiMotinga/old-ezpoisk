class AddCategoryToRePrivates < ActiveRecord::Migration[5.0]
  def change
    add_column :re_privates, :category, :string
  end
end
