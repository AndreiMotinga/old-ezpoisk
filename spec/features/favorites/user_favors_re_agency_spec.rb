require "rails_helper"

feature "User favors re_agency", js: true do
  scenario "user is not logged in" do
    create :re_agency, :active

    visit ezrealty_re_agencies_path
    page.find(".favor").click
    wait_for_ajax

    expect(Favorite.count).to eq 0
  end

  scenario "creates favorite when user is logged in", js: true do
    create_and_login_user
    create :re_agency, :active

    visit ezrealty_re_agencies_path
    page.find(".favor").click
    wait_for_ajax

    expect(Favorite.count).to eq 1
  end

  scenario "destroys favorite when user is logged in", js: true do
    user = create_and_login_user
    re_agency = create :re_agency, :active
    Favorite.create(user_id: user.id,
                    post_id: re_agency.id,
                    post_type: re_agency.class.to_s)

    visit ezrealty_re_agencies_path
    page.find(".favor").click
    wait_for_ajax

    expect(Favorite.count).to eq 0
  end
end
