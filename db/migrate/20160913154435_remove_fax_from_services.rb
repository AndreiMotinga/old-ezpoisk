class RemoveFaxFromServices < ActiveRecord::Migration[5.0]
  def change
    remove_column :services, :fax
  end
end
