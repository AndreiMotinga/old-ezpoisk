# sends email to user, when he was thanked for the first time
class PointNotifierJob
  include Sidekiq::Worker

  def perform(id, author_id)
    return if Rails.env.development?
    user = User.find(id)
    author = User.find(author_id)
    ProfileMailer.thanked(user, author).deliver_now
  end
end
