class CreateCompanies < ActiveRecord::Migration
  def change
    create_table :companies do |t|
      t.string :title
      t.string :phone
      t.string :email
      t.string :site
      t.string :category
      t.string :subcategory
      t.boolean :contacted
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
