module Fb
  # changes post received from fb api
  class Unifier
    attr_reader :post, :group

    def initialize(post, group)
      @post = post
      @group = group
    end

    def unified
      { date: post["created_time"],
        text: Media::Sanitizer.clean(post["message"]),
        vk: "",
        fb: "https://www.facebook.com/#{post['from']['id']}",
        attachments: attachments,
        state_id: group[:state_id],
        city_id: group[:city_id],
        model: group[:model] }
    end

    private

    def attachments
      Fb::Attachments.new(post["attachments"]).attachments
    end
  end
end
