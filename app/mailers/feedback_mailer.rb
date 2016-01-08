class FeedbackMailer < ApplicationMailer
  def feedback_email(feedback)
    @feedback = feedback
    mail(to: "andrew.motinga@gmail.com", subject: "New Feedback")
  end
end
