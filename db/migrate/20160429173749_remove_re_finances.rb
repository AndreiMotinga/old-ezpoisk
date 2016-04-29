class RemoveReFinances < ActiveRecord::Migration
  def change
    drop_table :re_finances
  end
end
