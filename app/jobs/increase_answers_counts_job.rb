class IncreaseAnswersCountsJob
  include Sidekiq::Worker

  def perform(id)
    return if Rails.env.test?
    Question.find(id).answers.find_each { |a| impressionist a }
  end
end
