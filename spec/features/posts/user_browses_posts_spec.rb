require "rails_helper"

feature "User browses posts" do
  scenario "success" do
    p = create :post

    visit posts_path

    expect(page).to have_content(p.title)
  end
end

feature "User browses post" do
  scenario "success" do
    p = create :post

    visit post_path p

    expect(page).to have_content(p.title)
  end
end
