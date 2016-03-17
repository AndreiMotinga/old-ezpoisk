class QuestionMailer < ApplicationMailer
  def new_activity(question, email)
    @question = question
    @email = email
    mail(to: @email, subject: @question.title)
  end
end
