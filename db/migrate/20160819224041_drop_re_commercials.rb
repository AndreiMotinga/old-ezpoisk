class DropReCommercials < ActiveRecord::Migration[5.0]
  def change
    drop_table :re_commercials
  end
end
