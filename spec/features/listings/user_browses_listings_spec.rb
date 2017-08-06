require "rails_helper"

feature "User filters listings" do
  scenario "success", js: true do
    create_list :listing, 11, kind: "недвижимость"

    visit listings_path(kind: "недвижимость")
    page.execute_script "window.scrollBy(0,10000)"
    # wait_for_ajax

    Listing.pluck(:text).map do |text|
      expect(page).to have_content text
    end
  end
end
