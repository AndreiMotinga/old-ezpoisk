class RemoveCreatedAtFromTaggings < ActiveRecord::Migration[5.0]
  def change
    remove_column :taggings, :created_at
  end
end
