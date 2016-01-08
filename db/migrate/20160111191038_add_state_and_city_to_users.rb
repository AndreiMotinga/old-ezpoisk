class AddStateAndCityToUsers < ActiveRecord::Migration
  def change
    add_reference :users, :state, index: true, foreign_key: true
    add_reference :users, :city, index: true, foreign_key: true
  end
end
