class AddTagsToAnswers < ActiveRecord::Migration[5.0]
  def change
    add_column :answers, :cached_tags, :string, default: ""
  end
end
