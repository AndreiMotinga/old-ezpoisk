class RemoveFeedbacksAgain < ActiveRecord::Migration[5.0]
  def change
    drop_table :feedbacks
  end
end
