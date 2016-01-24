class Ez
  def initialize
    @notifier = Slack::Notifier.new ENV["SLACK_URL"]
  end

  def ping(message)
    @notifier.ping message
  end
end
