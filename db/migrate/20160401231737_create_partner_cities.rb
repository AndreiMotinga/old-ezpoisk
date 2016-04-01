class CreatePartnerCities < ActiveRecord::Migration
  def change
    create_table :partner_cities do |t|
      t.references :partner, index: true, foreign_key: true
      t.references :city, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
