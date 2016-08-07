# increases impressions_count on records when viewed
class IncreaseImpressionsJob
  include Sidekiq::Worker

  def perform(ids, model)
    return if Rails.env.development?
    records = model.constantize.find(ids)
    records.each do |rec|
      rec.update_column(:impressions_count, rec.impressions_count + 1)
    end
  end
end
