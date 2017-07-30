# modifies vk post for easy creation of the listing
module Vk
  class Unifier
    attr_reader :post, :group, :unified, :user

    def initialize(post, group, user)
      @post = post
      @group = group
      @user = user
      @unified = unify
    end

    private

    def unify
      kind = group[:kind].to_sym
      user_name = user ? "#{user.first_name} #{user.last_name}" : "Anonymous"
      subcategory = kind == :"недвижимость" ? "квартира" : "другое-разное"
      rooms = kind == :"недвижимость" ? "комната" : ""
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
          vk: "https://vk.com/id#{post[:from_id]}",
          state_id: group[:state_id],
          city_id: group[:city_id],
          from_name: user_name,
          user_id: 1,
          created_at: Time.at(post[:date])
        }
      }
    end

    def attachments
      Vk::Attachments.new(post[:attachments]).attachments
    end

    def text
      @text ||= Media::Text.clean(post[:text])
    end
  end
end
