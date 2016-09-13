class AddAttachmentCoverToServices < ActiveRecord::Migration
  def self.up
    change_table :services do |t|
      t.attachment :cover
    end
  end

  def self.down
    remove_attachment :services, :cover
  end
end
