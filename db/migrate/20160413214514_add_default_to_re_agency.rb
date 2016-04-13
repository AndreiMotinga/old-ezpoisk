class AddDefaultToReAgency < ActiveRecord::Migration
  def change
    change_column :re_agencies, :description, :text, default: "", null: false
  end
end
