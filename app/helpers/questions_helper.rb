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

  # todo I dont need to pass vars in method here - see where else I can update code
  def subscription_links
    return log_in_trigger if !current_user
    return unsubscribe_link if current_user.subscribed?(@question.id)
    subscribe_link
  end

  def subscribe_link(q = @question)
    link_to "подписаться", subscribe_question_path(q), method: "put", remote: true, id: "subscribe", class: "text text-muted qa-links"
  end

  def unsubscribe_link(q = @question)
    link_to "отписаться", unsubscribe_question_path(q), method: "put", remote: true, id: "unsubscribe", class: "text text-muted qa-links"
  end

  def log_in_trigger
    link_to "подписаться", "", "data-target": "#new_session_modal", "data-toggle": "modal", id: "login_link", class: "text text-muted qa-links"
  end
end
