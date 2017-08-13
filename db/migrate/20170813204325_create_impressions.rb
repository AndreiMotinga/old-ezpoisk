class CreateImpressions < ActiveRecord::Migration[5.1]
  def change
    create_table :impressions do |t|
      t.references :impressionable, polymorphic: true
      t.string :kind
      t.references :user, foreign_key: true
      t.string :ip_address
      t.string :referrer

      t.timestamps
    end
  end
end
