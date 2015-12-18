class CreateRePrivates < ActiveRecord::Migration
  def change
    create_table :re_privates do |t|
      t.string :street, null: false
      t.string :post_type, null: false
      t.string :duration, null: false
      t.string :apt, null: false
      t.string :phone, null: false

      t.text :description, null: false

      t.integer :price
      t.integer :baths
      t.integer :space
      t.integer :rooms
      t.integer :zip
      t.float :latitude
      t.float :longitude

      t.boolean :active
      t.boolean :fee

      t.references :user, index: true, foreign_key: true
      t.references :state, index: true, foreign_key: true
      t.references :city, index: true, foreign_key: true
      t.references :picture, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
