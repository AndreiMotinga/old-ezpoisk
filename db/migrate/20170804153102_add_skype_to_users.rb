class AddSkypeToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :skype, :string, default: ""
  end
end
