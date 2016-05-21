module Helpers
  def create_and_login_user
    user = create :user
    login_as(user, scope: :user)
    user
  end

  def url_helpers
    Rails.application.routes.url_helpers
  end

  def deliveries
    ActionMailer::Base.deliveries
  end
end
