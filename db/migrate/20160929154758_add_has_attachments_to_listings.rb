class AddHasAttachmentsToListings < ActiveRecord::Migration[5.0]
  def change
    add_column :re_privates, :has_attachments, :boolean, default: false
    add_column :sales, :has_attachments, :boolean, default: false
    add_column :services, :has_attachments, :boolean, default: false
  end
end
