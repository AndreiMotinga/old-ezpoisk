class AddDefaultToDescAtReFinances < ActiveRecord::Migration
  def change
    change_column :re_finances, :description, :text, default: "", null: false
  end
end
