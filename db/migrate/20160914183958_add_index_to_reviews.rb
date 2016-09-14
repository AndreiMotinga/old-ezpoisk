class AddIndexToReviews < ActiveRecord::Migration[5.0]
  def change
    add_index :reviews, [:service_id, :user_id], unique: true
  end
end
