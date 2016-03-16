class IncreaseAnswersCountsJob
  include Sidekiq::Worker

  def perform(id)
    return if Rails.env.test?
    Question.find(id).answers.each { |a| a.increment!(:impressions_count) }
  end
end
