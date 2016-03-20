class NewsCleanerJob
  include Sidekiq::Worker
  include Sidetiq::Schedulable

  recurrence do
    daily.hour_of_day([1])
  end

  def perform
    return unless Rails.env.production?
    posts = User.find(4).posts
      .where("created_at < ?", 1.week.ago)
      .where(show_on_homepage: nil)
      .where(main: nil)
      .where(interesting: nil)
    Ez.ping("DESTROYING  #{posts.count} news posts")
    posts.destroy_all
  end
end
