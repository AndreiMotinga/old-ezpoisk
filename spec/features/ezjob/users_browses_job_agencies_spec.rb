require "rails_helper"

feature "User browses job_agencies" do
  scenario "success" do
    visit ezjob_job_agencies_path
    expect(page).to have_content("Настроить фильтр")
  end
end

feature "User browses job_agency" do
  scenario "success" do
    ja = create :job_agency, :active

    visit ezjob_job_agency_path(ja)

    expect(page).to have_content ja.title
  end
end
