class AddDefaultToDescAtServices < ActiveRecord::Migration
  def change
    change_column :services, :description, :text, default: "", null: false
  end
end
