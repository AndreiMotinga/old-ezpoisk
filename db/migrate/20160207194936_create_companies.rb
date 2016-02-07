class CreateCompanies < ActiveRecord::Migration
  def change
    create_table :companies do |t|
      t.string :email
      t.string :name
      t.string :phone

      t.timestamps null: false
    end
    add_index :companies, :email, unique: true
  end
end
