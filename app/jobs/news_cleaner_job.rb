class NewsCleanerJob
  include Sidekiq::Worker

  def perform
    Post.invisible.delete_all
    Ez.ping("all invisible posts deleted!")
  end
end
