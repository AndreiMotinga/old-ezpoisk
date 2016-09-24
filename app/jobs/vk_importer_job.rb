# imports records from vk
class VkImporterJob
  include Sidekiq::Worker

  def perform(type)
    VkImporter.new("re_privates").import
  end
end
