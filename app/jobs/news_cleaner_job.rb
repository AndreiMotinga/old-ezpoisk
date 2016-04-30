class NewsCleanerJob
  include Sidekiq::Worker
  include Sidetiq::Schedulable

  recurrence do
    daily.hour_of_day([1])
  end

  def perform
    return unless Rails.env.production?
    Post.invisible.destroy_all
  end
end
