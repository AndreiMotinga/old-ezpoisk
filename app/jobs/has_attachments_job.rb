# updates has_attachments cached column on record
class HasAttachmentsJob
  include Sidekiq::Worker

  def perform(id)
    pic = Picture.find(id)
    return if !pic || pic.imageable.pictures.count > 1
    pic.imageable.update_attribute(:has_attachments, true)
  end
end
