class CreateActions < ActiveRecord::Migration[5.1]
  def change
    create_table :actions do |t|
      t.references :actionable, polymorphic: true

      t.timestamps
    end
  end
end
