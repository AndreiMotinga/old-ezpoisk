class CreateExperiences < ActiveRecord::Migration[5.1]
  def change
    create_table :experiences do |t|
      t.string :kind, null: false
      t.string :name, null: false
      t.string :title, null: false
      t.string :country, null: false
      t.string :city, null: false
      t.integer :start_year, null: false
      t.integer :end_year
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
