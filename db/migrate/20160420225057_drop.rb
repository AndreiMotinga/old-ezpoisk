class Drop < ActiveRecord::Migration
  def change
    drop_table :partner_cities
  end
end
