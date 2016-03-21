class CreatePartnerPages < ActiveRecord::Migration
  def change
    create_table :partner_pages do |t|
      t.references :page, index: true, foreign_key: true
      t.references :partner, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
