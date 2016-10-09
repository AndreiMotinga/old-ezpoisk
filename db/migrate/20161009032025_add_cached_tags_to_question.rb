class AddCachedTagsToQuestion < ActiveRecord::Migration[5.0]
  def change
    add_column :questions, :cached_tags, :string
  end
end
