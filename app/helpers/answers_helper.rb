module AnswersHelper
  def upvote_answer_btn(answer)
    link_to "Upvote | #{answer.score}",
      upvote_answer_path(answer),
      method: :put,
      remote: true,
      class: "btn btn-success",
      id: "answer-upvote-#{answer.id}"
  end

  def voted_answer_btn(answer)
    link_to "Voted | #{answer.score}",
      unvote_answer_path(answer),
      method: :put,
      remote: true,
      class: "btn btn-default",
      id: "answer-voted-#{answer.id}"
  end

  def answer_name(answer)
    return answer.user.name unless answer.user.site.present?
    link_to answer.user.name, "//#{answer.user.site}", target: "_blank"
  end
end
