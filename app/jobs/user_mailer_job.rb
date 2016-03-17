class UserMailerJob
  include Sidekiq::Worker

  def perform(id)
    return unless Rails.env.production?
    user = User.find(id)
    UserMailer.welcome_email(user).deliver
  end
end
