class NewsCleanerJob
  include Sidekiq::Worker
  include Sidetiq::Schedulable

  recurrence do
    daily.hour_of_day([1])
  end

  def perform
    return if Rails.env.development?
    posts = Post.where("created_at < ?", 3.weeks.ago)
    Ez.ping("DESTROYING  #{posts.count} news posts")
    posts.destroy_all
  end
end
