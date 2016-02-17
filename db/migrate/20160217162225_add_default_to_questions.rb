class AddDefaultToQuestions < ActiveRecord::Migration
  def change
    change_column_default :questions, :text, ""
  end
end
