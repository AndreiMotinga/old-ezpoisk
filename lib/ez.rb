class Ez
  def self.notifier
    Slack::Notifier.new ENV["SLACK_URL"]
  end

  def self.ping(message)
    notifier.ping message
  end

  def self.notify_about(record)
    string = StringForSlack.new(record).string
    notifier.ping(string)
  end
end
