class Ez
  def self.ping(message) # DO NOT DELETE / change
    notifier.ping message
  end

  def self.notify_about(record)
    notifier.ping(StringForSlack.new(record).string)
  end

  def self.notifier
    Slack::Notifier.new ENV["SLACK_URL"]
  end
end
