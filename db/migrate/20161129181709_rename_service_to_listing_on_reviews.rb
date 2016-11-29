class RenameServiceToListingOnReviews < ActiveRecord::Migration[5.0]
  def change
    rename_column :reviews, :service_id, :listing_id
  end
end
