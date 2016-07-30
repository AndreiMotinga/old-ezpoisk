class UpdatePoints < ActiveRecord::Migration[5.0]
  def change
    rename_column :points, :profile_id, :author_id
  end
end
