# increases impressions_count on records when viewed
class IncreaseImpressionsJob
  include Sidekiq::Worker

  def perform(ids, model)
    records = model.constantize.find(ids)
    records.each do |rec|
      rec.update_column(:impressions_count, rec.impressions_count + 1)
    end
  end
end
