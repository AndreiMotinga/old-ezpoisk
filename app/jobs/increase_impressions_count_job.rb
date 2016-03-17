class IncreaseImpressionsCountJob
  include Sidekiq::Worker

  def perform(id, model)
    return unless Rails.env.production?
    post = model.constantize.find(id)
    return unless post.active
    post.increment!(:impressions_count)
  end
end
