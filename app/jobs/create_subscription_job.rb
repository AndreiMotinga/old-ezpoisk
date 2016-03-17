class CreateSubscriptionJob
  include Sidekiq::Worker

  def perform(user_id, q_id)
    return unless Rails.env.production?
    return if Subscription.exists?(user_id: user_id, question_id: q_id)
    Subscription.create(user_id: user_id, question_id: q_id)
  end
end
