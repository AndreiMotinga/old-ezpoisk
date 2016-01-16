class RemoveLinksFromHoroscopes < ActiveRecord::Migration
  def change
    remove_column :horoscopes, :day_link
    remove_column :horoscopes, :month_link
  end
end
