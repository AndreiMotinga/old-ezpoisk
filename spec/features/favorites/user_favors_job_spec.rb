require "rails_helper"

feature "User favors job", js: true do
  scenario "user is not logged in" do
    create :job, :active

    visit ezjob_jobs_path
    page.find(".favor").click
    wait_for_ajax

    expect(Favorite.count).to eq 0
  end

  scenario "creates favorite when user is logged in", js: true do
    create_and_login_user
    create :job, :active

    visit ezjob_jobs_path
    page.find(".favor").click
    wait_for_ajax

    expect(Favorite.count).to eq 1
  end

  scenario "destroys favorite when user is logged in", js: true do
    user = create_and_login_user
    job = create :job, :active
    Favorite.create(user_id: user.id,
                    post_id: job.id,
                    post_type: job.class.to_s)

    visit ezjob_jobs_path
    page.find(".favor").click
    wait_for_ajax

    expect(Favorite.count).to eq 0
  end
end
