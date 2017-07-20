# modifies vk post for easy creation of the listing
module Vk
  class Unifier
    attr_reader :post, :group, :unified

    def initialize(post, group)
      @post = post
      @group = group
      @unified = unify
    end

    private

    def unify
      kind = group[:kind].to_sym
      original_url = "https://vk.com/topic-#{group[:id]}_#{group[:topic]}?post=#{post[:id]}"
      {
        attachments: attachments,
        attributes: {
          title: post[:text].truncate(66),
          kind: kind,
          active: true,
          category: KINDS[kind][:categories].first,
          subcategory: KINDS[kind][:subcategories].first,
          text: Media::Sanitizer.clean(post[:text]),
          vk: "https://vk.com/id#{post[:from_id]}",
          state_id: group[:state_id],
          city_id: group[:city_id],
          user_id: 1,
          created_at: Time.at(post[:date]),
          original_url: original_url
        }
      }
    end

    def attachments
      Vk::Attachments.new(post[:attachments]).attachments
    end
  end
end
