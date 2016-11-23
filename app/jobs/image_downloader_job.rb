# creates images for posts, imported from vk and fb
class ImageDownloaderJob
  include Sidekiq::Worker

  def perform(id, pics)
    return if Rails.env.development?
    return if pics.empty?
    @record = Listing.find_by_id(id)
    return unless @record
    download(pics)
  end

  def download(pics)
    pics.each_with_index do |pic, i|
      Picture.create(
        imageable_id: @record.id,
        imageable_type: "Listing",
        user_id: 1,
        logo: i.zero?,
        image_remote_url: pic
      )
    end
  end
end
