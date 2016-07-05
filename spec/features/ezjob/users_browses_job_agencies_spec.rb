require "rails_helper"

feature "User browses job_agencies" do
  scenario "success" do
    ja = create :service, :job_agency, :active

    visit job_agencies_path

    expect(page).to have_content("Настроить фильтр")
    expect(page).to have_content ja.title
  end
end
