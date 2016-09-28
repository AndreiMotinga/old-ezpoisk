# sends message to fb user about listing added on his behalf
class FbUserNotifier
  def initialize(record)
    @graph = Koala::Facebook::API.new(ENV["FB_TOKEN"])
    @record = record
  end

  def notify
    return unless should_notify?
    # logic to send message to fb user
  end

  private

  def should_notify?
    # logic to determine whether I have a history with a user
    true
  end
end
