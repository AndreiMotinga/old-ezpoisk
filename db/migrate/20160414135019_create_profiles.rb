class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.references :user, index: true, foreign_key: true, unique: true
      t.string :name, default: ""
      t.string :phone, default: ""
      t.references :state, index: true, foreign_key: true
      t.references :city, index: true, foreign_key: true
      t.string :site, default: ""

      t.timestamps null: false
    end
  end
end
