class AddGenderToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :gender, :string, null: false, default: "male"
  end
end
