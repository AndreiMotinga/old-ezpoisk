class AddDeactivationsCountToLisings < ActiveRecord::Migration[5.0]
  def change
    add_column :re_privates, :deactivations_count, :integer, default: 0
    add_column :jobs, :deactivations_count, :integer, default: 0
    add_column :sales, :deactivations_count, :integer, default: 0
  end
end
