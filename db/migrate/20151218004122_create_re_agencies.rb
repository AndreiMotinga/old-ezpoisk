class CreateReAgencies < ActiveRecord::Migration
  def change
    create_table :re_agencies do |t|
      t.string :title, default: "", null: false
      t.string :street, default: "", null: false
      t.string :phone, default: "", null: false
      t.string :email, default: "", null: false
      t.string :site, default: ""
      t.text :description, default: ""
      t.boolean :active, default: false

      t.references :state, index: true, foreign_key: true
      t.references :city, index: true, foreign_key: true
      t.references :picture, index: true, foreign_key: true
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
