class AddAttachmentLogoToReAgencies < ActiveRecord::Migration
  def self.up
    change_table :re_agencies do |t|
      t.attachment :logo
    end
  end

  def self.down
    remove_attachment :re_agencies, :logo
  end
end
