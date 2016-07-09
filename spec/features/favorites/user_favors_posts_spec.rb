require "rails_helper"

feature "User favors different posts", js: true do
  scenario "user sees them in in dashboard", js: true do
    user = create_and_login_user
    re_private = create :re_private, :active
    re_commercial = create :re_commercial, :active
    job = create :job
    service = create :service
    sale = create :sale, :active

    Favorite.create(user_id: user.id, favorable_id: re_private.id, favorable_type: re_private.class.to_s, saved: true)
    Favorite.create(user_id: user.id, favorable_id: re_commercial.id, favorable_type: re_commercial.class.to_s, saved: true)
    Favorite.create(user_id: user.id, favorable_id: job.id, favorable_type: job.class.to_s, saved: true)
    Favorite.create(user_id: user.id, favorable_id: service.id, favorable_type: service.class.to_s, saved: true)
    Favorite.create(user_id: user.id, favorable_id: sale.id, favorable_type: sale.class.to_s, saved: true)

    visit dashboard_favorites_path

    expect(page).to have_selector('.listing', count: 5)
  end
end
