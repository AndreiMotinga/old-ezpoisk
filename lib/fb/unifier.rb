# frozen_string_literal: true
module Fb
  # changes post received from fb api
  class Unifier
    attr_reader :post, :group, :unified

    def initialize(post, group)
      @post = post
      @group = group
      @unified = unify
    end

    private

    def unify
      kind = group[:kind]
      url = "https://www.facebook.com/groups/#{group[:id]}/permalink/#{post['id']}"
      {
        attachments: attachments,
        attributes: {
          title: text.truncate(66),
          kind: kind,
          active: true,
          category: KINDS[kind][:categories].first,
          subcategory: KINDS[kind][:subcategories].first,
          original_url: url,
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

    def attachments
      Fb::Attachments.new(post["attachments"]).attachments
    end

    def text
      @text ||= Media::Sanitizer.clean(post["message"])
    end
  end
end
