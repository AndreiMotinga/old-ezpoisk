class CreateListings < ActiveRecord::Migration[5.0]
  def change
    create_table :listings do |t|
      t.string :title
      t.text :text
      t.string :category
      t.string :subcategory
      t.integer :impressions_count
      t.string :token
      t.boolean :active
      t.integer :priority
      t.boolean :featured
      t.references :user, foreign_key: true
      t.references :state, foreign_key: true
      t.references :city, foreign_key: true
      t.string :street
      t.float :lat
      t.float :lng
      t.integer :zip
      t.string :phone
      t.string :email
      t.string :site
      t.string :vk
      t.string :fb
      t.string :gl
      t.string :tw
      t.string :ok
      t.string :duration
      t.integer :price
      t.integer :baths
      t.integer :space
      t.integer :rooms
      t.boolean :fee

      t.timestamps
    end
  end
end
