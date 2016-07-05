class CreateStripeSubscriptions < ActiveRecord::Migration
  def change
    create_table :stripe_subscriptions do |t|
      t.belongs_to :service, index: true, foreign_key: true
      t.string :customer_id
      t.string :sub_id
      t.datetime :active_until

      t.timestamps null: false
    end
  end
end
