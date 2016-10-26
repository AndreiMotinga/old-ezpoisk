# changes post received from vk api
module Vk
  class Unifier
    attr_reader :post, :group

    def initialize(post, group)
      @post = post
      @group = group
    end

    def unified
      { date: Time.at(post[:date]),
        text: Media::Sanitizer.clean(post[:text]),
        vk: "https://vk.com/id#{post[:from_id]}",
        fb: "",
        attachments: attachments,
        state_id: group[:state_id],
        city_id: group[:city_id],
        model: group[:model] }
    end

    private

    def attachments
      Vk::Attachments.new(post[:attachments]).attachments
    end
  end
end
