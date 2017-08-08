class CreateContacts < ActiveRecord::Migration[5.1]
  def change
    create_table :contacts do |t|
      t.references :user, foreign_key: true
      t.string :phone
      t.string :vk
      t.string :fb
      t.string :google
      t.string :site
      t.string :skype
      t.string :street
      t.references :state, foreign_key: true
      t.references :city, foreign_key: true

      t.timestamps
    end
  end
end
