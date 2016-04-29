class DropReAgencies < ActiveRecord::Migration
  def change
    drop_table :re_agencies
  end
end
