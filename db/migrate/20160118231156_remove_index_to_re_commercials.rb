class RemoveIndexToReCommercials < ActiveRecord::Migration
  def change
    remove_index :re_commercials, :post_type
  end
end
