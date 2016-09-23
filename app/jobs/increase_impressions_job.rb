# increases impressions_count on records when viewed
class IncreaseImpressionsJob
  include Sidekiq::Worker

  def perform(ids, model)
    model.constantize.where(id: ids).each do |rec|
      next unless rec
      rec.update_column(:impressions_count, rec.impressions_count + 1)
    end
  end
end
