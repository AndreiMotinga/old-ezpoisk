class CreateJobs < ActiveRecord::Migration
  def change
    create_table :jobs do |t|
      t.string :title
      t.string :phone
      t.string :email
      t.string :category
      t.string :subcategory
      t.text :description
      t.boolean :active
      t.references :state, index: true, foreign_key: true
      t.references :city, index: true, foreign_key: true
      t.references :user, index: true, foreign_key: true
    end
  end
end
