# methods commonly used in specs
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

  def select3(value)
    first(".select2-container").click
    find(".select2-results__option", text: value).click
  end
end
