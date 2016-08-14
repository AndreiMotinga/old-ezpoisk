module SubscriptionHelper
  def subscription_links(record)
    return log_in_trigger unless current_user
    if current_user.subscribed?(record.id, record.class.to_s)
      return unsubscribe_link(record)
    end
    subscribe_link(record)
  end

  def subscribe_link(record)
    link_to "подписаться",
      subscriptions_path(id: record.id, type: record.class.to_s),
      method: "post", remote: true, id: "subscribe", class: "text text-muted qa-links", rel: "nofollow"
  end

  def unsubscribe_link(record)
    link_to "отписаться",
      subscription_path(id: record.id, type: record.class.to_s),
        method: "delete", remote: true, id: "unsubscribe", class: "text text-muted qa-links", rel: "nofollow"
  end
end
