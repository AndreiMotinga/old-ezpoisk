require "rails_helper"

feature "User browses re_agencies" do
  scenario "success" do
    re_agency = create :service, :re_agency

    visit re_agencies_path

    expect(page).to have_content("Настроить фильтр")
    expect(page).to have_content(re_agency.title)
  end
end

feature "User browses re_agency" do
  scenario "success" do
    ra = create :service, :re_agency

    visit re_agency_path(ra)

    expect(page).to have_content ra.title
  end
end
