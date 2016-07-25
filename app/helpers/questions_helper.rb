module QuestionsHelper
  def tag_links(question)
    sanitize question.tag_list
      .map { |tag| link_to "##{tag}", tag_path(tag), class: "tag" }.join
  end

  def tag_path(tag_id)
    "/ezanswer/tag/#{tag_id}"
  end

  def subscription_links
    return log_in_trigger unless current_user
    return unsubscribe_link(@question) if current_user.subscribed?(@question.id)
    subscribe_link(@question)
  end

  def subscribe_link(question)
    link_to "подписаться",
            subscribe_question_path(question),
            method: "put",
            remote: true,
            id: "subscribe",
            class: "text text-muted qa-links"
  end

  def unsubscribe_link(question)
    link_to "отписаться",
            unsubscribe_question_path(question),
            method: "put",
            remote: true,
            id: "unsubscribe",
            class: "text text-muted qa-links"
  end

  def log_in_trigger
    link_to "подписаться",
            "",
            "data-target" => "#new_session_modal",
            "data-toggle" => "modal",
            id: "login_link",
            class: "text text-muted qa-links"
  end
end
