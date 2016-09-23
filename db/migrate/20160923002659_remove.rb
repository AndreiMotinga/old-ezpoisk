class Remove < ActiveRecord::Migration[5.0]
  def change
    remove_column :re_privates, :source
    remove_column :jobs, :source
    remove_column :sales, :source
  end
end
