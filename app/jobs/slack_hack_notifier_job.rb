class SlackHackNotifierJob
  include Sidekiq::Worker
  sidekiq_options queue: :critical

  def perform(id)
    HackedMailer.youve_been_owned(User.find(id)).deliver_now
    2000.times { Ez.new.ping "Admin panel has been hacked !!!!!!!!!" }
  end
end
