# frozen_string_literal: true

# sends congratulation email to user, when his profile was visited 10 times
# todo ? remove or fix or whatever
class ProfileNotifierJob
  include Sidekiq::Worker

  def perform(id)
    return if Rails.env.development?
    user = User.find(id)
    ProfileMailer.ten_visitors(user).deliver_now
  end
end
