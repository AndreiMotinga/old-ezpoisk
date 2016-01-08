class FeedbackMailerJob
  include Sidekiq::Worker

  def perform(id)
    @feedback = Feedback.find(id)
    FeedbackMailer.feedback_email(@feedback).deliver
  end
end
