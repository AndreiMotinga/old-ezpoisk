class IncreaseAnswersCountsJob
  include Sidekiq::Worker

  def perform(id)
    Question.find(id).answers.each { |a| a.increment!(:impressions_count) }
  end
end
