class ChangeRoomsToStringOnApartments < ActiveRecord::Migration[5.0]
  def change
    change_column :listings, :rooms, :string
  end
end
