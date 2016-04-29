require "rails_helper"

feature "User browses job_agencies" do
  scenario "success" do
    ja = create :service, :job_agency

    visit job_agencies_path

    expect(page).to have_content("Настроить фильтр")
    expect(page).to have_content ja.title
  end
end

feature "User browses job_agency" do
  scenario "success" do
    ja = create :service, :job_agency

    visit job_agency_path(ja)

    expect(page).to have_content ja.title
  end
end
