require "rails_helper"

xfeature "User favors different posts", js: true do
  scenario "user sees them in in dashboard", js: true do
    user = create_and_login_user
    re_private = create :re_private

    Favorite.create(user_id: user.id,
                    favorable_id: re_private.id,
                    favorable_type: re_private.class.to_s,
                    saved: true)

    visit dashboard_favorites_path

    expect(page).to have_selector('.listing', count: 1)
  end
end
