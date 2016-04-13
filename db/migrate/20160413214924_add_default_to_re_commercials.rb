class AddDefaultToReCommercials < ActiveRecord::Migration
  def change
    change_column :re_commercials, :description, :text, default: "", null: false
  end
end
