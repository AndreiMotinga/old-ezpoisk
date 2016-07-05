class CreateEntries < ActiveRecord::Migration
  def change
    create_table :entries do |t|
      t.references :enterable, polymorphic: true, index: true
      t.timestamps null: false
    end
  end
end
