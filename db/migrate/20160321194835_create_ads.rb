class CreateAds < ActiveRecord::Migration
  def change
    create_table :ads do |t|
      t.references :user, index: true, foreign_key: true
      t.string :link

      t.timestamps null: false
    end
  end
end
