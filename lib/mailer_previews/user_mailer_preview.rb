class UserPreview < ActionMailer::Preview
  def welcome_email
    return if Rails.env.production?
    UserMailer.welcome_email(User.last)
  end
end
