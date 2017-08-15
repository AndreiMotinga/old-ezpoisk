class AddAttachmentImageToPartners < ActiveRecord::Migration[5.1]
  def self.up
    change_table :partners do |t|
      t.attachment :image
    end
  end

  def self.down
    remove_attachment :partners, :image
  end
end
