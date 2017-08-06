require "rails_helper"

feature "User" do
  scenario "scrolls down", js: true do
    kind = RU_KINDS.keys.sample
    create_list :listing, 11, kind: kind

    visit listings_path(kind: kind)
    page.execute_script "window.scrollBy(0,10000)"

    prm = kind == "услуги" ? :title : :text
    Listing.pluck(:text).map do |text|
      expect(page).to have_content text
    end
  end
end
