class CreateStripePlans < ActiveRecord::Migration
  def change
    create_table :stripe_plans do |t|
      t.string :name
      t.string :stripe_id
      t.string :interval
      t.integer :amount
      t.integer :total
      t.integer :priority

      t.timestamps null: false
    end
  end
end
