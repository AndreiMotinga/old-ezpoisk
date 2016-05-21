# sends messages to slack (ez channel)
class SlackNotifierJob
  include Sidekiq::Worker

  def perform(id, type)
    return if Rails.env.development?
    record = type.constantize.find(id)
    Ez.notify_about(record)
  end
end
