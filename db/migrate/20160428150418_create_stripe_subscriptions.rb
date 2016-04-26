class CreateStripeSubscriptions < ActiveRecord::Migration
  def change
    create_table :stripe_subscriptions do |t|
      t.string :stripe_id
      t.references :payable, polymorphic: true, index: true

      t.timestamps null: false
    end
  end
end
