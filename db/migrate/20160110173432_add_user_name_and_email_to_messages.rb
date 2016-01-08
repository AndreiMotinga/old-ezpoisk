class AddUserNameAndEmailToMessages < ActiveRecord::Migration
  def change
    add_column :messages, :name, :string
    add_column :messages, :email, :string
  end
end
