# frozen_string_literal: true

# wraps Slack::Notifier.
# posts messages directly to ez channel
class Ez
  def self.notifier
    Slack::Notifier.new ENV["SLACK_URL"], channel: ENV["SLACK_CHANNEL"]
  end

  def self.ping(message)
    notifier.ping message
  end

  def self.notify_about(record, type)
    name = record.class == User ? record.name : record.user.try(:name)
    string = "#{type} #{record.class} #{record.id} | author #{name} | #{record.try(:category)}\n\n"
    string += "#{strip_html_tags(record.try(:text))}\n"
    string += "<#{record.try(:show_url)}|show>"
    string += " | <#{record.try(:edit_url_with_token)}|edit>"
    notifier.ping(string)
  end

  def self.strip_html_tags(string)
    return "" unless string
    ActionView::Base.full_sanitizer.sanitize(string)
  end
end
