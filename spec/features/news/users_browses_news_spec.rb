require "rails_helper"

feature "User reads news" do
  scenario "successfully" do
    create :post, title: "first", main: true
    create :post, title: "second", main: true

    visit news_index_path

    expect(page).to have_content "first"
    expect(page).to have_content "second"
  end
end

feature "User reads post" do
  scenario "success" do
    post = create :post, interesting: true
    visit news_path post

    expect(page).to have_content(post.title)
    expect(page).to have_content(post.text)
  end
end
