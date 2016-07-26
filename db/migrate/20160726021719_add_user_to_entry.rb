class AddUserToEntry < ActiveRecord::Migration
  def change
    add_reference :entries, :user, index: true, foreign_key: true
  end
end
