require "rails_helper"

feature "User browses job_agencies" do
  scenario "success" do
    visit jobs_job_agencies_path
    expect(page).to have_content("Расширенный поиск")
  end
end

feature "User browses job_agency" do
  scenario "success" do
    ja = create :job_agency, :active

    visit jobs_job_agency_path(ja)

    expect(page).to have_content ja.title
  end
end
