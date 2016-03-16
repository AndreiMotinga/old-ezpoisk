class UserPreview < ActionMailer::Preview
  def welcome_email
    UserMailer.welcome_email(User.last)
  end
end
