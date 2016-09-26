# creates images for posts, imported from vk
class VkImageCreatorJob
  include Sidekiq::Worker

  def perform(pics, id, model)
    VkImageCreator.new(pics, id, model)
  end
end
