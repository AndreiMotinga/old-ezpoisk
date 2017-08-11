# frozen_string_literal: true

module AnswersHelper
  def upvote_answer_btn(answer)
    tag.a href: upvote_answer_path(answer),
          data: { method: :put, remote: true },
          class: "btn btn-xs btn-vote",
          id: "answer-upvote-#{answer.id}" do
      concat(tag.i(class: "fa fa-thumbs-up", "aria-hidden": "true"))
      concat(tag.span(" Вверх | #{answer.score}"))
    end
  end

  def voted_answer_btn(answer)
    tag.a href: unvote_answer_path(answer),
          data: { method: :put, remote: true },
          class: "btn btn-xs btn-vote",
          id: "answer-voted-#{answer.id}" do
      tag.span "Засчитано | #{answer.score}"
    end
  end

  def downvote_btn(answer)
    tag.a href: downvote_answer_path(answer),
          data: { method: :put, remote: true },
          class: "text text-muted qa-links" do
      concat(tag.i(class: "fa fa-thumbs-down", "aria-hidden": "true"))
      concat(tag.span(" Вниз"))
    end
  end
end
