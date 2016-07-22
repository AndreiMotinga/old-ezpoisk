# restrict number of ips that admin panel can be reached from
class BlacklistConstraint
  IPS = [
    ENV["MY_IP_ONE"],
    ENV["GRETA_IP"],
  ].freeze

  def matches?(request)
    return true unless Rails.env.production?
    IPS.include?(request.remote_ip)
  end
end
