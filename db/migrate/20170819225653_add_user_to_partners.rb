class AddUserToPartners < ActiveRecord::Migration[5.1]
  def change
    add_reference :partners, :user, foreign_key: true
  end
end
