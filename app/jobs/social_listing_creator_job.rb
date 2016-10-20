class SocialListingCreatorJob
  include Sidekiq::Worker
  sidekiq_options queue: 'critical'

  def perform(record, group)
    # todo use symbolize keys instead
    record = record.inject({}){|memo,(k,v)| memo[k.to_sym] = v; memo}
    group = group.inject({}){|memo,(k,v)| memo[k.to_sym] = v; memo}
    return unless SocialPostValidator.new(group[:model], record).cool?
    SocialListingCreator.new(record, group).create
  end
end
