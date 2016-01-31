class SlackHackNotifierJob
  include Sidekiq::Worker
  sidekiq_options queue: :critical

  def perform(id)
    return if Rails.env.development? || Rails.env.test?
    HackedMailer.youve_been_owned(User.find(id)).deliver_now
    2000.times { Ez.ping "Admin panel has been hacked !!!!!!!!!" }
  end
end
