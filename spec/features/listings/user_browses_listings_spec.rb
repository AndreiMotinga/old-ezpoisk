require "rails_helper"

feature "User filters listings" do
  scenario "success", js: true do
    create_list :listing, 20, kind: "недвижимость"

    visit listings_path(kind: "недвижимость")
    page.execute_script "window.scrollBy(0,10000)"
    wait_for_ajax

    Listing.pluck(:title).map do |title|
      expect(page).to have_content title
    end
  end
end
