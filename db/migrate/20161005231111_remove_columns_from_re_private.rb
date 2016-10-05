class RemoveColumnsFromRePrivate < ActiveRecord::Migration[5.0]
  def change
    remove_column :re_privates, :logo_url
    remove_column :re_privates, :has_attachments
  end
end
