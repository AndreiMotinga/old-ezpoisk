class BlacklistConstraint
  def initialize
    @ips =[ ENV["MY_IP_ONE"], ENV["GRETA_IP"], ENV["SERGHEI_IP"] ]
  end

  def matches?(request)
    return true if Rails.env.development? || Rails.env.text?
    @ips.include?(request.remote_ip)
  end
end
