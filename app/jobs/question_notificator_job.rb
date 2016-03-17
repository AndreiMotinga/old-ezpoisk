class QuestionNotificatorJob
  include Sidekiq::Worker

  def perform(id)
    # return if Rails.env.development? || Rails.env.test?
    q = Question.find(id)
    emails = q.subscribers.pluck(:email)
    emails.each {|email| QuestionMailer.new_activity(q, email).deliver }
  end
end
