class CreateReviews < ActiveRecord::Migration[5.0]
  def change
    create_table :reviews do |t|
      t.references :service, foreign_key: true
      t.references :user, foreign_key: true
      t.integer :rating, null: false
      t.text :text, null:false

      t.timestamps
    end
  end
end
