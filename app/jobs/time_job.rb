# todo remove
class TimeJob
  include Sidekiq::Worker
  sidekiq_options queue: 'critical'

  def perform
    puts("tick")
  end
end
