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
      {
        attachments: attachments,
        attributes: {
          title: "Dummy title",
          kind: kind,
          category: KINDS[kind][:categories].first,
          subcategory: KINDS[kind][:subcategories].first,
          text: Media::Sanitizer.clean(post[:text]),
          vk: "https://vk.com/id#{post[:from_id]}",
          state_id: group[:state_id],
          city_id: group[:city_id],
          user_id: 1,
          created_at: Time.at(post[:date])
        }
      }
    end

    def attachments
      Vk::Attachments.new(post[:attachments]).attachments
    end
  end
end
