# frozen_string_literal: true

module Fb
  # changes post received from fb api
  class Unifier
    attr_reader :post, :group

    def self.unify(post, group)
      new(post, group).unify
    end

    def initialize(post, group)
      @post = post
      @group = group
    end

    def unify
      kind = group[:kind]
      subcategory = kind == "недвижимость" ? "квартира" : "другое-разное"
      rooms = kind == "недвижимость" ? "комната" : ""
      {
        attachments: attachments,
        attributes: {
          title: Media::Title.of(text),
          kind: kind,
          active: true,
          category: RU_KINDS[kind][:categories].first,
          subcategory: subcategory,
          rooms: rooms,
          text: text,
          fb: "https://www.facebook.com/#{post['from']['id']}",
          from_name: post['from']['name'],
          state_id: group[:state_id],
          user_id: 1,
          city_id: group[:city_id],
          created_at: post["created_time"]
        }
      }
    end

    private

    def attachments
      Fb::Attachments.new(post["attachments"]).attachments
    end

    def text
      @text ||= Media::Text.clean(post["message"])
    end
  end
end
