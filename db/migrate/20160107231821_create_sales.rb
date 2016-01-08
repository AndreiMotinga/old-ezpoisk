class CreateSales < ActiveRecord::Migration
  def change
    create_table :sales do |t|
      t.string :title
      t.string :category
      t.string :phone
      t.string :email

      t.text :description
      t.boolean :active

      t.float :lat
      t.float :lng

      t.references :user, index: true, foreign_key: true
      t.references :state, index: true, foreign_key: true
      t.references :city, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
