# todo rename to downloader
class VkImageCreator
  def initialize(pics, id, model)
    @pics = pics
    @record = model.constantize.find_by_id(id)
    return unless @record
    download_pictures
  end

  def download_pictures
    @pics.each_with_index do |pic, i|
      Picture.create(
        imageable_id: @record.id,
        imageable_type: @record.class.to_s,
        user_id: 181,
        logo: i == 0,
        image_remote_url: pic
      )
    end
  end
end
