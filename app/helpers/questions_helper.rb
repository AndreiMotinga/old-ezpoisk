module QuestionsHelper
  def upvote_btn(q)
    link_to "Upvote | #{q.score}",
      upvote_question_path(q),
      method: :put,
      remote: true,
      class: "btn btn-success",
      id: "upvote-#{q.id}"
  end

  def voted_btn(q)
    link_to "Voted | #{q.score}",
      unvote_question_path(q),
      method: :put,
      remote: true,
      class: "btn btn-default",
      id: "voted-#{q.id}"
  end
end
