class NewsCleanerJob
  include Sidekiq::Worker

  def perform
    Post.invisible.destroy_all
    Ez.ping("all invisible posts deleted!")
  end
end
