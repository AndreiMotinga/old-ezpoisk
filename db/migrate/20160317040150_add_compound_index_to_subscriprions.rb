class AddCompoundIndexToSubscriprions < ActiveRecord::Migration
  def change
    add_index :subscriptions, [:user_id, :question_id], unique: true
  end
end
