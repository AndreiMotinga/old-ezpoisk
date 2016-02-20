require "rails_helper"

feature "User browses re_agencies" do
  scenario "success" do
    visit real_estate_re_agencies_path
    expect(page).to have_content("Расширенный поиск")
  end
end

feature "User browses re_agency" do
  scenario "success" do
    ra = create :re_agency, :active

    visit real_estate_re_agency_path(ra)

    expect(page).to have_content ra.title
  end
end
