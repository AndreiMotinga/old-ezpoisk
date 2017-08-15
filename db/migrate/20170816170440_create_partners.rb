class CreatePartners < ActiveRecord::Migration[5.1]
  def change
    create_table :partners do |t|
      t.string :final_url
      t.string :title
      t.string :headline
      t.string :description
      t.references :campaign, foreign_key: true

      t.timestamps
    end
  end
end
