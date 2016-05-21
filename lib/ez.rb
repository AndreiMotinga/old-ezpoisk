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
    string = StringForSlack.string_for(record)
    notifier.ping(string)
  end
end
