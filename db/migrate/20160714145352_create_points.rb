class CreatePoints < ActiveRecord::Migration
  def change
    create_table :points do |t|
      t.references :profile, index: true, foreign_key: true
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
