class CreateReCommercials < ActiveRecord::Migration
  def change
    create_table :re_commercials do |t|
      t.string :category, null: false
      t.string :street, null: false
      t.string :phone, null: false
      t.string :post_type, null: false
      t.text :description, default: ""

      t.integer :price, default: 0
      t.integer :space, default: 0
      t.integer :zip

      t.float :latitude
      t.float :longitude
      t.boolean :active, default: false

      t.references :user, index: true, foreign_key: true
      t.references :state, index: true, foreign_key: true
      t.references :city, index: true, foreign_key: true
      t.references :picture, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
