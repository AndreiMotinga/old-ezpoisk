# increases impressions_count on records when viewed
class IncreaseImpressionsJob
  include Sidekiq::Worker

  def perform(ids, model)
    model.constantize.where(id: ids).each do |rec|
      next unless rec
      rec.increment!(:impressions_count)
    end
  end
end
