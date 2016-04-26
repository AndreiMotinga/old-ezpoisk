class CreatePlans < ActiveRecord::Migration
  def change
    create_table :plans do |t|
      t.string :title
      t.string :name
      t.integer :amount
      t.string :currency
      t.string :interval

      t.timestamps null: false
    end
  end
end
