module QuestionsHelper
  def upvote_btn(question)
    link_to("Upvote | #{question.score}",
            upvote_question_path(question),
            method: :put,
            remote: true,
            class: "btn btn-success",
            id: "upvote-#{question.id}")
  end

  def voted_btn(question)
    link_to("Voted | #{question.score}",
            unvote_question_path(question),
            method: :put,
            remote: true,
            class: "btn btn-default",
            id: "voted-#{question.id}")
  end

  def tag_links(question)
    sanitize question.tag_list
      .map { |tag| link_to "##{tag}", tag_path(tag), class: "tag" }.join(" ")
  end

  def tag_path(tag_id)
    "/ezanswer/tag/#{tag_id}"
  end
end
