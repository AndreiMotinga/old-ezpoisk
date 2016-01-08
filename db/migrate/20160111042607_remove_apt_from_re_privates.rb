class RemoveAptFromRePrivates < ActiveRecord::Migration
  def change
    remove_column :re_privates, :apt
  end
end
