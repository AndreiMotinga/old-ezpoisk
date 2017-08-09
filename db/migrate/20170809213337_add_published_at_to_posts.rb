class AddPublishedAtToPosts < ActiveRecord::Migration[5.1]
  def change
    add_column :posts, :published, :datetime, null: false, default: Time.zone.now
  end
end
