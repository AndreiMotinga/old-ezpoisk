class ReCreatePoint < ActiveRecord::Migration[5.0]
  def change
    create_table :points do |t|
      t.integer :author_id
      t.references :user, index: true, foreign_key: true

      t.timestamps null: true
    end
  end
end
