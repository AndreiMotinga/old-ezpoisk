module Helpers
  def create_and_login_user
    user = create :user
    login_as(user, scope: :user)
    user
  end

  # todo remove
  def attrs_with_state_and_city(model)
    attrs = attributes_for(model)
    attrs[:state_id] = 32
    attrs[:city_id] = 18031
    attrs
  end

  def url_helpers
    Rails.application.routes.url_helpers
  end
end
