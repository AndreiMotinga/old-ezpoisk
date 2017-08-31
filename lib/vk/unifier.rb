# frozen_string_literal: true

# modifies vk post for easy creation of the listing
module Vk
  class Unifier
    attr_reader :post, :group, :user

    def self.unify(post, group, user)
      new(post, group, user).unify
    end

    def initialize(post, group, user)
      @post = post
      @group = group
      @user = user
    end

    def unify
      {
        attachments: attachments,
        user: {
          provider: "vkontakte",
          uid: user.id,
          avatar_remote_url: user.photo_100,
          gender: (user.sex == "1" ? "female" : "male"),
          name: "#{user.first_name} #{user.last_name}"
        },
        attributes: {
          title: Media::Title.of(text),
          kind: kind,
          active: true,
          category: category,
          subcategory: subcategory,
          rooms: rooms,
          text: text,
          vk: "https://vk.com/id#{post[:from_id]}",
          state_id: group["state_id"],
          city_id: group["city_id"],
          source: "https://vk.com/topic-#{group['id']}_#{group['topic']}?post=#{post[:id]}",
          created_at: Time.at(post[:date])
        }
      }
    end

    private

    def subcategory
      kind == "недвижимость" ? "квартира" : "другое-разное"
    end

    def rooms
      kind == "недвижимость" ? "комната" : ""
    end

    def category
      return "продаю" unless RU_KINDS.keys.include?(kind)
      RU_KINDS[kind][:categories].first
    end

    def kind
      group["kind"].to_sym
    end

    def attachments
      Vk::Attachments.new(post[:attachments]).attachments
    end

    def text
      Media::Text.clean(post[:text])
    end
  end
end
