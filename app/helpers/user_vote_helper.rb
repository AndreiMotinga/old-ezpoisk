# frozen_string_literal: true

module UserVoteHelper
  def user_upvote_btn(record)
    type = record.class.to_s.downcase
    tag.a href: "/profiles/#{record.id}/upvote",
          data: { method: :put, remote: true },
          class: "btn btn-xs btn-vote js-login",
          id: "#{type}-upvote-#{record.id}" do
      concat(tag.i(class: "fa fa-thumbs-up", "aria-hidden": "true"))
      concat(tag.span(" Поблагодарить"))
    end
  end

  def user_voted_btn(record)
    type = record.class.to_s.downcase
    tag.a href: "/profiles/#{record.id}/unvote",
          data: { method: :put, remote: true },
          class: "btn btn-xs btn-vote js-login",
          id: "#{type}-voted-#{record.id}" do
      concat(tag.span("Ёр вэлкам :)"))
    end
  end
end
