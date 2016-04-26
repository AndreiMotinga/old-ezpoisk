class RemoveShortDescriptionFromServices < ActiveRecord::Migration
  def change
    remove_column :services, :short_description
  end
end
