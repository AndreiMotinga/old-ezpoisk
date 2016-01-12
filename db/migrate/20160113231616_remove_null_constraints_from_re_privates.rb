class RemoveNullConstraintsFromRePrivates < ActiveRecord::Migration
  def change
    change_column :re_privates, :space, :integer, null: true
    change_column :re_privates, :baths, :integer, null: true
  end
end
