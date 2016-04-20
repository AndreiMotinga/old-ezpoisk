class SlackNotifierJob
  include Sidekiq::Worker

  def perform(id, type)
    # todo uncomment
    # return unless Rails.env.production?
    record = type.constantize.find(id)
    Ez.notify_about(record)
  end
end
