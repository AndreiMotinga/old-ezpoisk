# wraps Slack::Notifier.
# used to post messages directly to ez channel
class Ez
  def self.notifier
    Slack::Notifier.new ENV["SLACK_URL"]
  end

  def self.ping(message)
    notifier.ping message
  end

  def self.notify_about(record, type = nil)
    if type == 'update'
      string = "UPDATE |  #{record.class}\n id #{record.id}\n\n"
    else
      string = "NEW    |  #{record.class}\n id #{record.id}\n\n"
    end
    string += "#{record.show_url}"
    notifier.ping(string)
  end
end
