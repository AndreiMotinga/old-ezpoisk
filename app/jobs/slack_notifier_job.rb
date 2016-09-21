# sends messages to slack (ez channel)
class SlackNotifierJob
  include Sidekiq::Worker

  def perform(id, model, type = "new")
    record = model.constantize.find(id)
    return unless record
    Ez.notify_about(record, type)
  end
end
