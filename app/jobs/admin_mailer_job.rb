class AdminMailerJob
  include Sidekiq::Worker

  def perform(id, type)
    record = type.constantize.find(id)
    AdminMailer.notify_about(record).deliver
  end
end
