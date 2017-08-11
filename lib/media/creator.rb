# frozen_string_literal: true

# creates listings from posts provided by vk and fb importers
module Media
  class Creator
    attr_reader :attributes, :attachments

    def initialize(post)
      @attributes = post[:attributes]
      @attachments = post[:attachments]
    end

    def create
      listing = Listing.create(attributes)
      ImageDownloaderJob.perform_in(1.minute, listing.id, attachments)
    end
  end
end
