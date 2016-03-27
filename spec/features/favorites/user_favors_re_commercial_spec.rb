require "rails_helper"

feature "User favors re_commercial", js: true do
  scenario "user is not logged in" do
    create :re_commercial, :active

    visit ezrealty_re_commercials_path
    page.find(".favor").click
    wait_for_ajax

    expect(Favorite.count).to eq 0
  end

  scenario "creates favorite when user is logged in", js: true do
    create_and_login_user
    create :re_commercial, :active

    visit ezrealty_re_commercials_path
    page.find(".favor").click
    wait_for_ajax

    expect(Favorite.count).to eq 1
  end

  scenario "destroys favorite when user is logged in", js: true do
    user = create_and_login_user
    re_commercial = create :re_commercial, :active
    Favorite.create(user_id: user.id,
                    post_id: re_commercial.id,
                    post_type: re_commercial.class.to_s,
                    favorite: true)

    visit ezrealty_re_commercials_path
    page.find(".favor").click
    wait_for_ajax

    expect(Favorite.count).to eq 0
  end
end
