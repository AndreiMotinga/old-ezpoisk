class Ez
  def initialize
    @notifier = Slack::Notifier.new ENV["SLACK_URL"]
  end

  def ping(*args)
    @notifier.ping args.join ","
  end
end
