class AddIndexToQuestions < ActiveRecord::Migration
  def change
    add_index :questions, :title
  end
end
