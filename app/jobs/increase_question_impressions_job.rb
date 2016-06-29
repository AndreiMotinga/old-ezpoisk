# manually (fake) increase impressions_count on all the models
class IncreaseQuestionImpressionsJob
  include Sidekiq::Worker

  def perform(id)
    return if Rails.env.development?
    q = Question.find(id)
    q.update_column(:impressions_count, q.impressions_count + 1)
    q.answers.find_each do |a|
      a.update_column(:impressions_count, a.impressions_count + 1)
    end
  end
end
