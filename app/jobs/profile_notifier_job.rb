# sends congratulation email to user, when his profile was visited 10 times
class ProfileNotifierJob
  include Sidekiq::Worker

  def perform(id)
    # return if Rails.env.development?
    user = User.find(id)
    ProfileMailer.ten_visitors(user).deliver_now
  end
end
