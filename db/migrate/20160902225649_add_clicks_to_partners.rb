class AddClicksToPartners < ActiveRecord::Migration[5.0]
  def change
    add_column :partners, :clicks, :integer, default: 0, null: false
  end
end
