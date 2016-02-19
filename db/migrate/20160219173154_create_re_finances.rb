class CreateReFinances < ActiveRecord::Migration
  def change
    create_table :re_finances do |t|
      t.string :title
      t.string :street
      t.string :phone
      t.string :email
      t.string :site
      t.string :fax
      t.boolean :active
      t.text :description
      t.references :state, index: true, foreign_key: true
      t.references :city, index: true, foreign_key: true
      t.references :user, index: true, foreign_key: true
      t.float :lat
      t.float :lng
      t.integer :zip
      t.string :logo_file_name
      t.string :logo_content_type
      t.integer :logo_file_size
      t.datetime :logo_updated_at

      t.timestamps null: false
    end
  end
end
