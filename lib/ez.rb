# wraps Slack::Notifier.
# used to post messages directly to ez channel
class Ez
  def self.notifier
    Slack::Notifier.new ENV["SLACK_URL"], channel: ENV["SLACK_CHANNEL"]
  end

  def self.ping(message)
    notifier.ping message
  end

  def self.notify_about(record, type = nil)
    type = type.present? ? type : "new"
    name = record.class == User ? record.name_to_show : record.user.try(:name_to_show)
    string = "#{type} | #{record.class} #{record.id} | author #{name}\n\n"
    string += record.try(:desctiption) if record.try(:desctiption)
    string += "#{record.show_url}"
    notifier.ping(string)
  end
end
