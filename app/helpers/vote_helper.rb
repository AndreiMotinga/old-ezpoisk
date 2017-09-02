# frozen_string_literal: true

module VoteHelper
  def upvote_btn(record)
    type = record.class.to_s.downcase
    tag.a href: "/#{record.class.table_name}/#{record.id}/upvote",
          data: { method: :put, remote: true },
          rel: "nofollow",
          class: "btn btn-xs btn-vote js-login",
          id: "#{type}-upvote-#{record.id}" do
      concat(tag.i(class: "fa fa-thumbs-up", "aria-hidden": "true"))
      concat(tag.span(" Вверх | #{record.score}"))
    end
  end

  def voted_btn(record)
    type = record.class.to_s.downcase
    tag.a href: "/#{record.class.table_name}/#{record.id}/unvote",
          data: { method: :put, remote: true },
          rel: "nofollow",
          class: "btn btn-xs btn-vote js-login",
          id: "#{type}-voted-#{record.id}" do
      tag.span "Засчитано | #{record.score}"
    end
  end

  def downvote_btn(record)
    tag.a href: "/#{record.class.table_name}/#{record.id}/downvote",
          data: { method: :put, remote: true },
          rel: "nofollow",
          class: "text text-muted js-login" do
      concat(tag.i(class: "fa fa-thumbs-down", "aria-hidden": "true"))
      concat(tag.span(" Вниз"))
    end
  end
end
