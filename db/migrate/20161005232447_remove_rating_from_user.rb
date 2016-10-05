class RemoveRatingFromUser < ActiveRecord::Migration[5.0]
  def change
    remove_column :services, :rating
  end
end
