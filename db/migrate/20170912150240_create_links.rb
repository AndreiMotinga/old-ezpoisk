class CreateLinks < ActiveRecord::Migration[5.1]
  def change
    create_table :links do |t|
      t.string :title
      t.text :description
      t.string :category
      t.string :address
      t.string :phone
      t.string :email
      t.string :site
      t.string :pictures

      t.timestamps
    end
  end
end
