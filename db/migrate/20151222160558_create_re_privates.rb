class CreateRePrivates < ActiveRecord::Migration
  def change
    create_table :re_privates do |t|
      t.string :street, null: false, default: ""
      t.string :post_type, null: false, default: ""
      t.string :duration, null: false, default: ""
      t.string :apt, null: false, default: ""
      t.string :phone, null: false, default: ""

      t.integer :price, null: false, default: 0
      t.integer :baths, null: false, default: 0
      t.integer :space, null: false, default: 0
      t.integer :rooms, null: false, default: 0
      t.integer :zip

      t.float :latitude
      t.float :longitude
      t.boolean :active, default: false
      t.boolean :fee, default: false

      t.text :description, default: ""
      t.references :user, index: true, foreign_key: true
      t.references :state, index: true, foreign_key: true
      t.references :city, index: true, foreign_key: true
      t.references :picture, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
