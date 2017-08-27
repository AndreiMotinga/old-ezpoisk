class CreateKarmas < ActiveRecord::Migration[5.1]
  def change
    create_table :karmas do |t|
      t.references :user, foreign_key: true
      t.references :giver, index: true, foreign_key: { to_table: :users }
      t.references :karmable, polymorphic: true
      t.string :kind, null: false
      t.integer :amount, null: false

      t.timestamps
    end
  end
end
