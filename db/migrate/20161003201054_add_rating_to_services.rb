class AddRatingToServices < ActiveRecord::Migration[5.0]
  def change
    add_column :services, :rating, :integer, default: 0
  end
end
