module AnswersHelper
  def upvote_answer_btn(answer)
    link_to("Upvote | #{answer.score}",
            upvote_answer_path(answer),
            method: :put,
            remote: true,
            class: "btn btn-xs btn-vote margin-bottom-10",
            id: "answer-upvote-#{answer.id}")
  end

  def voted_answer_btn(answer)
    link_to("Voted | #{answer.score}",
            unvote_answer_path(answer),
            method: :put,
            remote: true,
            class: "btn btn-xs btn-vote margin-bottom-10",
            id: "answer-voted-#{answer.id}")
  end
end
