class BlacklistConstraint
  def initialize
    @whitelist = [ENV["MY_API_ONE"], ENV["GRETA_IP"], ENV["SERGHEI_IP"]].freeze
  end

  def matches?(request)
    !@whitelist.include?(request.remote_ip)
  end
end
