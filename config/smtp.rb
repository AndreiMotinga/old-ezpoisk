SMTP_SETTINGS = {
  address: ENV.fetch("SMTP_ADDRESS"), # example: "smtp.sendgrid.net"
  authentication: :plain,
  domain: ENV.fetch("SMTP_DOMAIN"), # example: "heroku.com"
  password: ENV.fetch("SMTP_PASSWORD"),
  enable_starttls_auto: true,
  port: "587",
  user_name: ENV.fetch("SMTP_USERNAME")
}

if ENV["EMAIL_RECIPIENTS"].present?
  Mail.register_interceptor RecipientInterceptor.new(ENV["EMAIL_RECIPIENTS"])
end
