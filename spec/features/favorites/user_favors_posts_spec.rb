require "rails_helper"

feature "User favors different posts", js: true do
  scenario "user sees them in in dashboard", js: true do
    user = create_and_login_user
    re_agency = create :re_agency, :active
    re_finance = create :re_finance
    re_private = create :re_private, :active
    re_commercial = create :re_commercial, :active
    job_agency = create :job_agency, :active
    job = create :job, :active
    service = create :service, :active
    sale = create :sale, :active
    post = create :post

    Favorite.create(user_id: user.id, post_id: re_agency.id, post_type: re_agency.class.to_s, favorite: true)
    Favorite.create(user_id: user.id, post_id: re_finance.id, post_type: re_finance.class.to_s, favorite: true)
    Favorite.create(user_id: user.id, post_id: re_private.id, post_type: re_private.class.to_s, favorite: true)
    Favorite.create(user_id: user.id, post_id: re_commercial.id, post_type: re_commercial.class.to_s, favorite: true)
    Favorite.create(user_id: user.id, post_id: job_agency.id, post_type: job_agency.class.to_s, favorite: true)
    Favorite.create(user_id: user.id, post_id: job.id, post_type: job.class.to_s, favorite: true)
    Favorite.create(user_id: user.id, post_id: service.id, post_type: service.class.to_s, favorite: true)
    Favorite.create(user_id: user.id, post_id: sale.id, post_type: sale.class.to_s, favorite: true)
    Favorite.create(user_id: user.id, post_id: post.id, post_type: post.class.to_s, favorite: true)
    visit dashboard_favorites_path

    expect(page).to have_selector('.post-item', count: 9)
  end
end
