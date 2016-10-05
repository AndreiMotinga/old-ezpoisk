class AddCreatedAtToTaggings < ActiveRecord::Migration[5.0]
  def change
    add_column :taggings, :created_at, :timestamp
  end
end
