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
      {
        attachments: attachments,
        user: {
          provider: "facebook",
          uid: uid,
          avatar_remote_url: "http://graph.facebook.com/#{uid}/picture?type=normal",
          name: post["from"]["name"]
        },
        attributes: {
          title: Media::Title.of(text),
          kind: kind,
          active: true,
          approved: false,
          category: category,
          subcategory: subcategory,
          rooms: rooms,
          text: text,
          fb: "https://www.facebook.com/#{post['from']['id']}",
          state_id: group["state_id"],
          city_id: group["city_id"],
          source: post["permalink_url"],
          created_at: post["created_time"]
        }
      }
    end

    private

    def category
      return "продаю" unless RU_KINDS.keys.include?(kind.to_s)
      RU_KINDS[kind][:categories].first
    end

    def kind
      group["kind"]
    end

    def subcategory
      kind == "недвижимость" ? "квартира" : "другое-разное"
    end

    def rooms
      kind == "недвижимость" ? "комната" : ""
    end

    def uid
      post["from"]["id"]
    end

    def attachments
      Fb::Attachments.new(post["attachments"]).attachments
    end

    def text
      @text ||= Media::Text.clean(post["message"])
    end
  end
end
