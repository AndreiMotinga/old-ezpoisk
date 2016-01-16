class RemoveFieldsFromHorocope < ActiveRecord::Migration
  def change
    remove_column :horoscopes, :link
    remove_column :horoscopes, :category
    remove_column :horoscopes, :description
    remove_column :horoscopes, :week_link
    remove_column :horoscopes, :week_description
  end
end
