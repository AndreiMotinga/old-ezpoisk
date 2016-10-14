class CreateMyComments < ActiveRecord::Migration[5.0]
  def change
    create_table :comments do |t|
      t.belongs_to :user, foreign_key: true
      t.references :commentable, polymorphic: true
      t.text :text
      t.timestamps
    end
  end
end
