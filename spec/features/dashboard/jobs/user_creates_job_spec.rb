require "rails_helper"

feature "user creates job" do
  scenario "successfully", js: true do
    create_and_login_user

    visit new_dashboard_job_path
    job = build(:job)

    fill_in "Заголовок", with: job.title
    fill_in "Телефон", with: job.phone
    fill_in "Email", with: job.email
    find("option[value='#{job.category}']").select_option
    find("option[value='#{job.subcategory}']").select_option
    select("Alabama", from: "Штат")
    select("Abbeville", from: "Город")
    check("Активно")

    click_on "Сохранить"

    expect(page).to have_content job.category

    saved_job = Job.last
    expect(saved_job.active).to be true
    expect(saved_job.category).to eq job.category
    expect(saved_job.subcategory).to eq job.subcategory
    expect(saved_job.state_id).to_not be nil
    expect(saved_job.city_id).to_not be nil
    expect(saved_job.user_id).to_not be nil
  end
end
