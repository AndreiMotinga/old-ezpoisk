module QuestionsHelper
  def tag_links(question)
    sanitize question.tag_list
      .map { |tag| link_to "##{tag}", tag_path(tag), class: "tag" }.join
  end

  def tag_path(tag_id)
    "/ezanswer/tag/#{tag_id}"
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
