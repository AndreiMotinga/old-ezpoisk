class RenameMessagesToFeedbacks < ActiveRecord::Migration
  def change
    rename_table :messages, :feedbacks
  end
end
