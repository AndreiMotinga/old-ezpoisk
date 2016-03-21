class AddDefaultToReFinances < ActiveRecord::Migration
  def change
    change_column :re_finances, :description, :text, default: ""
  end
end
