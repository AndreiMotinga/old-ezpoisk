class RemoveTimestampFromCategories < ActiveRecord::Migration[5.0]
  def change
    remove_column :categories, :created_at
    remove_column :categories, :updated_at
  end
end
