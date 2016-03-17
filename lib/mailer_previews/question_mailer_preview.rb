class QuestionPreview < ActionMailer::Preview
  def new_activity
    return if Rails.env.production?
    q = Question.find(29)
    QuestionMailer.new_activity(q, "andrei@yapp.us")
  end
end
