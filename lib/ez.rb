# wraps Slack::Notifier.
# used to post messages directly to ez channel
class Ez
  def self.notifier
    Slack::Notifier.new ENV["SLACK_URL"], channel: ENV["SLACK_CHANNEL"]
  end

  def self.ping(message)
    notifier.ping message
  end

  def self.notify_about(record, type)
    name = record.class == User ? record.name_to_show : record.user.try(:name_to_show)
    string = "#{type} #{record.class} #{record.id} | author #{name} | #{record.category}\n\n"
    string += "#{strip_html_tags(record.try(:text))}\n"
    string += "<#{record.show_url}|show>"
    string += " | <#{record.edit_url_with_token}|edit>"
    notifier.ping(string)
  end

  def self.strip_html_tags(string)
    return "" unless string
    ActionView::Base.full_sanitizer.sanitize(string)
  end
end
