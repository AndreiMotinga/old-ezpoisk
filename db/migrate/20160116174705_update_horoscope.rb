class UpdateHoroscope < ActiveRecord::Migration
  def change
    add_column :horoscopes, :day_link, :string
    add_column :horoscopes, :week_link, :string
    add_column :horoscopes, :month_link, :string

    add_column :horoscopes, :day_description, :string
    add_column :horoscopes, :week_description, :string
    add_column :horoscopes, :month_description, :string
  end
end
