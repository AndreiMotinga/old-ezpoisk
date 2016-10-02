require "rails_helper"

feature "user updates job" do
  scenario "successfully", js: true do
    user = create_and_login_user
    job = create(:job, user: user)

    visit edit_dashboard_job_path job
    click_on "Детали"
    attrs = build(:job)

    fill_in "Заголовок", with: attrs.title
    fill_in "Телефон", with: attrs.phone
    fill_in "Email", with: attrs.email
    select("Alabama", from: "Штат")
    select("Abbeville", from: "Город")
    fill_in "Описание", with: attrs.text
    check("Активно")

    click_on "details-save-btn"

    expect(page).to have_content I18n.t(:post_saved)
    job.reload
    expect(job.title).to eq attrs.title
    expect(job.phone).to eq attrs.phone
    expect(job.email).to eq attrs.email
    expect(job.active).to be true
    expect(job.state.name).to eq "Alabama"
    expect(job.city.name).to eq "Abbeville"
    expect(job.text).to eq attrs.text
  end
end
