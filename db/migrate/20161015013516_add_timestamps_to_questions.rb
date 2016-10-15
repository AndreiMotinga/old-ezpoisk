class AddTimestampsToQuestions < ActiveRecord::Migration[5.0]
  def change
    add_column(:questions, :created_at, :datetime)
    add_column(:questions, :updated_at, :datetime)
  end
end
