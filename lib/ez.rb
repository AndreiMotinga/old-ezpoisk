# wraps Slack::Notifier.
# used to post messages directly to ez channel
class Ez
  def self.notifier
    Slack::Notifier.new ENV["SLACK_URL"]
  end

  def self.ping(message)
    notifier.ping message
  end

  def self.notify_about(record)
    string = "Регистрация нового  #{record.class}\n id #{record.id}\n\n"
    string += "#{record.show_url}"
    notifier.ping(string)
  end
end
