class AddShowEmailToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :show_email, :boolean, default: true
  end
end
