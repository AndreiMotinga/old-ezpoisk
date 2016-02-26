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

  def tag_links(question)
    sanitize question.tag_list.map { |t| link_to t, tag_path(t) }.join(', ')
  end

  def tag_path(t)
    "/ezanswer/tag/#{t}"
  end
end
