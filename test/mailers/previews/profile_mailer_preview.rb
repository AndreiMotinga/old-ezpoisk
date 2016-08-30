class ProfileMailerPreview < ActionMailer::Preview
  def ten_visitors
    return if Rails.env.production?
    ProfileMailer.ten_visitors(User.last)
  end

  def thanked
    return if Rails.env.production?
    ProfileMailer.thanked(User.last, User.find(84))
  end
end
