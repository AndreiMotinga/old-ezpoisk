class CreateFavorites < ActiveRecord::Migration
  def change
    create_table :favorites do |t|
      t.belongs_to :user, index: true, foreign_key: true
      t.string :post_id
      t.string :post_type
    end
  end
end
