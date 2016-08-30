class ListingsMailerPreview < ActionMailer::Preview
  def ten_visits
    return if Rails.env.production?
    ListingsMailer.ten_visits(RePrivate.last)
  end
end
