class AddDefaultToRePrivates < ActiveRecord::Migration
  def change
    change_column :re_privates, :description, :text, default: "", null: false
  end
end
