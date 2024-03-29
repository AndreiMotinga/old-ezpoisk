# frozen_string_literal: true

# notifies user of new activity on question
class QuestionMailer < ApplicationMailer
  def new_activity(question, email)
    @question = question
    @email = email
    mail(to: @email, subject: @question.title)
  end
end
