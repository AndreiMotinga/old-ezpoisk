class RemoveTables < ActiveRecord::Migration[5.0]
  def change
    remove_foreign_key :reviews, :services
    drop_table :deactivations
    drop_table :jobs
    drop_table :points
    drop_table :re_privates
    drop_table :sales
    drop_table :services
    drop_table :stripe_plans

  end
end
