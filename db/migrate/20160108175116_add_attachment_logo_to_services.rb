class AddAttachmentLogoToServices < ActiveRecord::Migration
  def self.up
    change_table :services do |t|
      t.attachment :logo
    end
  end

  def self.down
    remove_attachment :services, :logo
  end
end
