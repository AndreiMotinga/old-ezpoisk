class CreateServices < ActiveRecord::Migration
  def change
    create_table :services do |t|
      t.string :title
      t.string :street
      t.string :phone
      t.string :email
      t.string :site
      t.string :category
      t.string :subcategory
      t.text :description
      t.boolean :active
      t.references :user, index: true, foreign_key: true
      t.references :city, index: true, foreign_key: true
      t.references :state, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
