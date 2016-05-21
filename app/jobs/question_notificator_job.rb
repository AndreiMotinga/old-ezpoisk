# sends "new_activity" emails to question subscribers
class QuestionNotificatorJob
  include Sidekiq::Worker

  def perform(id)
    return if Rails.env.development?
    question = Question.find(id)
    emails = question.subscribers_emails
    emails.each do |email|
      QuestionMailer.new_activity(question, email).deliver
    end
  end
end
