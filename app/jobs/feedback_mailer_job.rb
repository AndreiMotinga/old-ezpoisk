class FeedbackMailerJob
  include Sidekiq::Worker

  def perform(id)
    @message = Message.find(id)
    FeedbackMailer.feedback_email(@message).deliver
  end
end
