require "rails_helper"

feature "User reads news" do
  scenario "successfully" do
    create :post, title: "first"
    create :post, title: "second"

    visit news_index_path

    expect(page).to have_content "first"
    expect(page).to have_content "second"
  end
end
