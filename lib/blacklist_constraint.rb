class BlacklistConstraint
  def initialize
    @ips =[ ENV["MY_API_ONE"], ENV["GRETA_API"], ENV["SERGHEI_API"] ]
  end

  def matches?(request)
    return true if Rails.env == "development" || Rails.env == "test"
    @ips.include?(request.remote_ip)
  end
end
