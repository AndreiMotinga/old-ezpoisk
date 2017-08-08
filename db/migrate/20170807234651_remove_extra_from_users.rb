class RemoveExtraFromUsers < ActiveRecord::Migration[5.1]
  def change
    remove_attachment :users, :cover
    remove_column :users, :reset_password_token
    remove_column :users, :reset_password_sent_at
    remove_column :users, :failed_attempts
    remove_column :users, :unlock_token
    remove_column :users, :locked_at
    remove_column :users, :lat
    remove_column :users, :lng
    remove_column :users, :zip
    remove_column :users, :state_slug
    remove_column :users, :city_slug
    remove_column :users, :show_email
  end
end
