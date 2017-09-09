class RemoveTrashFromPartner < ActiveRecord::Migration[5.1]
  def change
    remove_column :partners, :keywords
    remove_column :partners, :first
  end
end
