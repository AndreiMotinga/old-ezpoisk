class CreateGalleries < ActiveRecord::Migration[5.0]
  def change
    create_table :galleries do |t|
      t.belongs_to :user, foreign_key: true

      t.timestamps null: true
    end
  end
end
