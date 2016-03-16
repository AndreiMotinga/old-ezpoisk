class NewsImpressionsCounterJob
  include Sidekiq::Worker

  def perform(id)
    Post.find(id).increment!(:impressions_count)
  end
end
