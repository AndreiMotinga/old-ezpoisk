class FeedbackMailer < ApplicationMailer
  def feedback_email(message)
    @message = message
    mail(to: "andrew.motinga@gmail.com", subject: "New Feedback")
  end
end
