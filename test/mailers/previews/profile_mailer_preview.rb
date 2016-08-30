class ProfileMailerPreview < ActionMailer::Preview
  def ten_visitors
    return if Rails.env.production?
    ProfileMailer.ten_visitors(User.last)
  end
end
