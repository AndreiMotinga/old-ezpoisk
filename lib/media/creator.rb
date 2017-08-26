# frozen_string_literal: true

# creates listings from posts provided by vk and fb importers
module Media
  class Creator
    attr_reader :attributes, :attachments, :user

    def self.create(post)
      new(post).create
    end

    def initialize(post)
      @attributes = post[:attributes]
      @attachments = post[:attachments]
      @user ||= find_or_create(post[:user])
    end

    def create
      listing = user.listings.create(attributes)
      ImageDownloaderJob.perform_in(1.minute, listing.id, attachments)
    end

    def find_or_create(user)
      User.where(provider: user[:provider], uid: user[:uid])
        .first_or_create(user)
    end
  end
end
