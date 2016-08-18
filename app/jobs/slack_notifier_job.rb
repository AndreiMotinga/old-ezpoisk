# sends messages to slack (ez channel)
class SlackNotifierJob
  include Sidekiq::Worker

  def perform(id, model, type = nil)
    record = model.constantize.find(id)
    Ez.notify_about(record, type)
  end
end
