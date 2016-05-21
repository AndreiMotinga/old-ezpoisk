module Helpers
  def create_alabama_and_abbeville
    state = State.find_by_name("Alabama")
    create(:city, :abbeville, state: state)
  end

  def create_and_login_user
    user = create :user
    login_as(user, scope: :user)
    user
  end

  def attrs_with_state_and_city(model)
    attrs = attributes_for(model)
    attrs[:state_id] = 32
    attrs[:city_id] = create(:city).id
    attrs
  end
end
