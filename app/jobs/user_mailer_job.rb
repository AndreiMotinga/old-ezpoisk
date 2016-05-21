# sends welcome_email to user
class UserMailerJob
  include Sidekiq::Worker

  def perform(id)
    return if Rails.env.development?
    user = User.find(id)
    UserMailer.welcome_email(user).deliver_now
  end
end
