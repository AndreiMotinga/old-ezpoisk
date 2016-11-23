# increases impressions_count on records when viewed
class IncreaseImpressionsJob
  include Sidekiq::Worker

  # todo remove model - use listing
  def perform(ids, model)
    model.constantize.where(id: ids).each do |rec|
      next unless rec
      rec.increment!(:impressions_count)
      rec.touch if [Post, Answer, Question].include?(rec.class)
    end
  end
end
