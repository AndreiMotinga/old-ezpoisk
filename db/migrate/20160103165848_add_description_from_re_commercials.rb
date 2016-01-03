class AddDescriptionFromReCommercials < ActiveRecord::Migration
  def change
    add_column :re_commercials, :description, :string, default: ""
  end
end
