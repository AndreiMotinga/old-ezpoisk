class RemoveHasAttachmentsAndLogoUrlFromSalesAndServices < ActiveRecord::Migration[5.0]
  def change
    remove_column :sales, :logo_url
    remove_column :sales, :has_attachments
    remove_column :services, :logo_url
    remove_column :services, :has_attachments
  end
end
