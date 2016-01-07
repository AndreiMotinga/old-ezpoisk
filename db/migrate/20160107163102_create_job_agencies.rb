class CreateJobAgencies < ActiveRecord::Migration
  def change
    create_table :job_agencies do |t|
      t.string :title
      t.string :street
      t.string :phone
      t.string :email
      t.string :site
      t.text :description
      t.boolean :active
      t.references :state, index: true, foreign_key: true
      t.references :city, index: true, foreign_key: true
      t.references :user, index: true, foreign_key: true
      t.float :lat
      t.float :lng
      t.integer :zip

      t.timestamps null: false
    end
  end
end
