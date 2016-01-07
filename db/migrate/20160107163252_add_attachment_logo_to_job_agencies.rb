class AddAttachmentLogoToJobAgencies < ActiveRecord::Migration
  def self.up
    change_table :job_agencies do |t|
      t.attachment :logo
    end
  end

  def self.down
    remove_attachment :job_agencies, :logo
  end
end
