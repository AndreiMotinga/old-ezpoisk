class SlackNotifierJob
  include Sidekiq::Worker

  def perform(id, type)
    return if Rails.env.development? || Rails.env.test?
    record = type.constantize.find(id)
    Ez.notify_about(record)
  end
end
