class CreateHoroscopes < ActiveRecord::Migration
  def change
    create_table :horoscopes do |t|
      t.string :title
      t.string :link
      t.string :description
      t.string :category

      t.timestamps null: false
    end
  end
end
