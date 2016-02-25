class ChangeRoomsOnPrivates < ActiveRecord::Migration
  def change
    change_column :re_privates, :rooms, :string
  end
end
