class CreateDeactivations < ActiveRecord::Migration[5.0]
  def change
    create_table :deactivations do |t|
      t.references :deactivatable, polymorphic: true
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
