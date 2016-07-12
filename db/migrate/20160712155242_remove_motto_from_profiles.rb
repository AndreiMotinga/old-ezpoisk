class RemoveMottoFromProfiles < ActiveRecord::Migration
  def change
    remove_column :profiles, :motto
  end
end
