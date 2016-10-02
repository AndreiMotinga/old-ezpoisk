class AddIndexToSlugOnAnswers < ActiveRecord::Migration[5.0]
  def change
    add_index :answers, :slug
  end
end
