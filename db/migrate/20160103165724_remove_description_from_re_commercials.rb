class RemoveDescriptionFromReCommercials < ActiveRecord::Migration
  def change
    remove_column :re_commercials, :description
  end
end
