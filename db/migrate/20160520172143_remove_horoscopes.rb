class RemoveHoroscopes < ActiveRecord::Migration
  def change
    drop_table :horoscopes
  end
end
