class AddShortBioToUsers < ActiveRecord::Migration[5.1]
  def change
    rename_column :users, :slug, :short_bio
  end
end
