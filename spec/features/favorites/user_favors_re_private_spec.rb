require "rails_helper"

feature "User favors re_private", js: true do
  scenario "user is not logged in" do
    create :re_private, :active

    visit re_privates_path
    page.find(".favor").click
    wait_for_ajax

    expect(Favorite.count).to eq 0
  end

  scenario "creates favorite when user is logged in", js: true do
    create_and_login_user
    create :re_private, :active

    visit re_privates_path
    page.find(".favor").click
    wait_for_ajax

    expect(Favorite.count).to eq 1
  end

  scenario "destroys favorite when user is logged in", js: true do
    user = create_and_login_user
    re_private = create :re_private, :active
    Favorite.create(user_id: user.id,
                    post_id: re_private.id,
                    post_type: re_private.class.to_s,
                    favorite: true)

    visit re_privates_path
    page.find(".favor").click
    wait_for_ajax

    expect(Favorite.count).to eq 0
  end
end
