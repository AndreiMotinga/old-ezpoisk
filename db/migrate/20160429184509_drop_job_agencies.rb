class DropJobAgencies < ActiveRecord::Migration
  def change
    drop_table :job_agencies
  end
end
